# The system alerts

`src/alert/` (library `alert`) is the Newton's last-resort way of telling
the user something: a box drawn straight into the screen's bits, over
whatever is there, by code that asks nothing of QuickDraw, the view system
or NewtonScript - which may be the very thing that is stuck. The card
server's "Newton still needs the card you removed" is one (the only one
this ROM puts up in normal use); the operating system error alert and the
"erase the persistent data" alert are others. Reconstructed from the
MP2x00 US ROM (0x0002e7d4-0x00030bcc, and the card server's at
0x0004ac54-0x0004b0d0, `pcmcia/CardAlerts.h`).

## How an alert is put up

1. Whoever wants one (the card server) fills in a `TAlertDialog` - a
   rectangle, some text items, some buttons (`TAlertItem`s), a filter
   proc - and sends it in a `TAlertEvent` to the alert manager, the `'alrt`
   world (`TAlertManager`, `InitAlertManager`, which `TLoader::TheMain`
   starts before the card server; the host starts it from the newt world's
   `MainConstructor`). The items are found by offsets from the dialog, so
   the manager can copy the whole thing as one block of its `fSize`.
2. The manager puts the copy in front of its list, takes down whatever
   alert was up, and puts the new one up (`DisplayAlert`): the pen is
   switched to polling (so taps go to the alert, not the inker), the
   alert's place on the display worked out - a quarter of the way down in
   whole eight-row bands, centred in 32-pixel steps (`gDisplayRect`) - the
   LCD blocked, and the alert drawn (`DrawAlert`).
3. Drawing: the alert is drawn **into the screen's own bits at its own
   bounds** - which for every ROM alert are (0, 0, 80, 192), the top-left
   corner of the screen - and that rectangle is then blitted by the screen
   driver onto the display at `gDisplayRect`. The screen's bits there are
   simply overwritten; the alert manager tells the application to redraw
   the whole screen (`'draw`, `HandleRedrawEvent`) when the last alert has
   gone, which puts them right. The drawing is its own: lines a 32-bit
   screen word at a time at depths 1, 2 and 4 (`AlertFastLine` - only
   horizontal and vertical lines), rectangles as runs of lines, and text
   in the ROM's `alertFont`, an `'sfnt` read glyph by glyph out of its
   bitmap strike (`TAlertGlyph`) into a 16 x 16 cell and ORed onto the
   screen (`DrawDChar`), wrapped at spaces.
4. Every 200 ms the manager's idler asks the front alert whether it is done
   (`CheckAlertDone`): a button tapped - the pen tracked directly through
   `PollTablet`, the button inverted while the pen is on it - or its filter
   proc saying so. The card reinsert alert has no buttons; its filter
   (`TCardServer::CardReinsertAlertProc`) says it is done once the card is
   back and active.

## The card reinsert alert

A card is pulled out while one of its stores is in use - locked, as a store
is while it is being written to. The PSS manager cannot let the store go
(`CardGone` answers 0x35), so the card server marks the card as having a
task held on it and sends the alert manager its `TCardReinsertAlertDialog`
(`Setup`: the text is `uCardReinsertAlertText`, or, with a reason set by
`SetCardReinsertReason`, "The package ... still needs the card", the box
32 pixels taller). When the same card goes back in, the card server finds
it is the same card (0x36; the PSS manager's `CardIsSame` asks the store,
0x37), the handler's services resume, the alert's filter says it is done
and it comes down, and the store carries on where it was.

On the machine the other way in is a fault: `ReinsertCard` touches the
card's memory, which with the card out faults into the card domains' fault
monitor, which holds the task and has the card server put the alert up.
The host's card memory never faults (DEVIATION: no fault monitor), so
that way in holds nobody.

ctest `host.NewtonCardAlert` (`src/host/demo/card-alert.ns`) locks a card's
store, pulls the card, sees the alert on the display (`ScreenPixel`),
snapshots it (`build/card-alert.png`), puts the card back and finds the
alert gone and the entry still readable.

## Deviations

- `BlockLCDActivity`: the ROM takes the screen semaphores so that nobody
  else updates the LCD while an alert is up. The host's screen has no
  semaphores yet; instead what is drawn meanwhile is kept dirty and shown
  when the LCD is let go (`qd/Screen.cpp`).
- `SetAlertScreenInfo` and `gAlertScreenInfo` live in `qd/Screen.cpp`, with
  `SetScreenInfo`, so that QuickDraw does not depend on the alert library.
- A filter proc is a member function in the ROM (its object in the first
  register); the host passes a static function that calls it.
- The redraw goes to the port named "newt" (the ROM: `gNewtPort`, a library
  above this one).

## ROM quirks kept

- The alert font is asked for its strike at size 9 - passed to
  `LocateEntry` as it is, where it takes a 16.16 size - so the strike used
  is the one nearest nought: the smallest.
- `GetAlertGlyphWidth` checks a glyph against the strike's range with `&&`
  where `||` was meant, so a glyph outside it is never replaced by the
  missing glyph. ROM bug, fixed by default (`NEWTON_ROM_BUGS=1` for the
  ROM's behaviour).
- At depth 2, `DrawDChar` ORs each byte of a glyph into the low half of a
  halfword it reads with an unaligned load: the glyph is drawn at half its
  width, a byte in every other byte (the MessagePad's screen is four bits
  deep, so it is never seen; `--display 320x480x2` shows it). ROM bug,
  fixed by default (`NEWTON_ROM_BUGS=1` for the ROM's behaviour).
- A centred text item (a button's label) that fits is drawn whole - the
  count used is the string's length, not the characters measured (they
  differ when those fill the width exactly). ROM bug, fixed by default
  (`NEWTON_ROM_BUGS=1` for the ROM's behaviour).
- A line that is neither horizontal nor vertical is drawn vertical, at its
  leftmost column.
- An alert taken off the manager's list is not freed.
- The button hit rectangles are the button's place on the display moved
  two pixels down and one to the left.
- `OSErrorAlert` and `OSWarningAlert` are empty in this ROM
  (`kError_Call_Not_Implemented`).

## The PIN pad (`alert/PinPad.h`)

`TDrawInterface` is a protocol for drawing straight onto the screen and
reading the pen with nothing else running, and `TPinPad` (0x00189f78-
0x0018a424, class info 0x00388704, 0xb8 bytes) the ROM's implementation,
in this library because its text is the alerts' (`TAlertGlyph`). `Init`
puts the box the right way round, cuts it to the screen, starts polling
the tablet directly (`SetTabletPolling`, the former state kept), blocks the
LCD's activity, holds the screen's drawing over the box (`StartDrawing`)
and opens a port of its own clipped to it, with the system font, 9 point,
bold as the style and its family's `boldData` strikes for the glyphs; it
answers what `SetTabletPolling` leaves in `r0`, 0. `DrawPict` and
`DrawText` draw (`DrawPicture`; `DrawTextOnce` at the point, in the
style and `DefineStyle`'s transfer mode) and blit what changed to the
screen; `GetTextWidth` adds up the alert font's advances of the strike
`TAlertGlyph` finds for the style's size (a 16.16 size: the smallest
strike, as for the alerts); `DefineStyle` takes a font spec and the
strikes of its face (plain, bold, italic, both); `GetPoint` polls the pen
as `AlertGetPoint` does; `Delete` erases the box, shows it, puts the port
and the polling back and lets the LCD and the screen go. ROM bug, fixed
by default: `Delete` leaves the style's ref handle (and a pattern its
font spec made) behind. Nothing in the ROM makes one - `InitGraf`
registers it for code outside the ROM (on the host the boot registers it
after `InitAlertManager`, `RegisterPinPad`, the alert library being above
QuickDraw's). Ctest `alert.PinPad` (a host display: the box, the text
drawn and shown, a polled point, everything put back).

## Not yet

- The low-battery and bad-adapter alerts, which the NewtonScript side
  raises (`'batteryAlert`, `'badBatteryAlert`, `'badAdapterAlert`) - they
  are views, not these.
- `TCardPositionAlertDialog` is made and given its text, but nothing in
  the card server puts it up yet (the card position check).
