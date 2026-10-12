# The T-Deck Pro as a phone: calls, messages and (perhaps) faxes

*Begun 2026-10-12, branch `tdeck-cellular`.  The owner's board is the
T-Deck Pro's 4G variant: a SIMCom A7682E on UART1.  The owner's earlier
firmware for the same board, lilyphone1 (PlatformIO, Arduino, LVGL), made
and took calls and sent and received texts on it; its modem service
(`src/peripherals/peri_modem.cpp`) is where the AT dialect below comes
from.*

## What NewtonOS 2.1 already has

The ROM carries a whole telephony framework (established by reading
`romsrc/`, the decompiled ROM objects):

- **The Calls application** (Extras) is only the call log: the data
  definition `'calllog` under `'callapp` (`romsrc/objects/misc-004.ns`).
- **The Phone transport**, `|PhoneHome:Newton|` (`obj_6471d9`), titled
  "Phone", owner `'callapp`, does the work.  The Names card's Call action
  (`kDoCallSlip`, Cardfile) opens its routing slip.
  - *Outgoing*: `SendRequest` → `InstallEndpoint` → `FinishDialing`, which
    calls `callEndpoint:MakeOutgoing(number)`; statuses "Dialing ^0…" to
    "Call to ^0 in progress…".
  - *Incoming*: `EventIncoming` plays the ring sound (@102), makes a log
    item, asks `callEndpoint:GetCallerId()` when the provider has caller
    ID, and shows "Call from ^0…" with a **Take Call** button, which is
    `receiveRequestComplete` → `AnswerIncoming`.  `StartAutoReceive`
    ("Ready for call…") listens when the preference `phoneAutoReceive`
    is set; `EventOffHook`/`EventOnHook` follow the handset.
- **The call endpoint** is `@662` (`obj_6489bd`, `'tapiEndpoint`, a
  protoBasicEndpoint @383 with the service option `"taps"`):
  `MakeOutgoing` (option `"outg"`), `AnswerIncoming` (`"answ"`),
  `hangup`, `SendDigit`, `Hold`/`UnHold`, `Transfer`, `Forward`,
  `GetCallerId` (a `"rout"` address option read back) and `SetSpeaker`.
  Its `eventHandler` takes event code 7 with data 1 incoming, 2 ringer, 4
  clear display, 5 off hook, 6 on hook, 8 conversation, 9 dial tone, 10
  ringback, 11 busy, 12 reorder.
- **Providers are pluggable**: `RegCommConfig(sym, frame)` puts one in
  `CommConfigRegistry`; `GetTAPICommFrame` reads it back (none: `{name:
  "Telephone"}`).  A provider says what it can do in its `config`:
  `supportsMakeOutgoing`, `supportsSendDigit`, `supportsEventIncoming`,
  `supportsCallerId`, `supportsAnswerIncoming`, `outgoingNeededDelay`,
  `supportsLineCurrentSense`.  The Phone preferences' "Using" picker
  (`obj_647a51`) lists the registered ones.
- **The ROM registers none.**  A MessagePad alone has only "Telephone":
  the number dialled as tones from the speaker held to a handset
  (`RawDial`).  The modem tool (`comms/ModemTool.h`) has the TAPI service
  option (`kCMOTAPIService`, the off-hook and on-hook commands `X1H1`,
  `H0X`), for a Hayes voice modem.

So a call needs no new application: a cellular **provider** registered with
`RegCommConfig`, its service a comm tool that answers the `taps` endpoint's
options over the module, makes the ROM's own Phone transport and Calls log
make, take and log calls (step 2).

**Messages**: the ROM has nothing for SMS - a new transport is needed (texts
received into the In Box, sent from any routing slip; step 3).

**Faxes**: the ROM's fax tool (`comms/fax/FaxTool.h`) sends and receives
over a Class 1/2 modem.  An LTE module carries no circuit-switched data,
and the A7682E's voice audio goes to its own codec pins, not to the
ESP32-S3 - so no fax over the module (AT+FCLASS=? to be asked of the real
one).  An internet fax service over the data connection would be the way
(step 4).

## Step 1: the module driven (2026-10-12)

**The engine** (`src/host/HostCellular.h`, `.cpp`) is portable C++: one
thread owns the module's byte link and speaks AT to it; the Newton's side
asks through a request queue and reads a status snapshot and two queues
(call events, received texts).  It has none of the Newton's headers (it is
its own library, `host_cellular`, because `<thread>` and `<mutex>` reach
`<locale.h>`, which `src/intl/Locale.h` would shadow).  Kept from
lilyphone1:

- configuration: `ATE0`, `AT+CMEE=1`, `AT+CLIP=1`, text mode
  (`AT+CMGF=1`) with the GSM character set, messages stored in the SIM and
  their slots told (`AT+CPMS="SM",...`, `AT+CNMI=2,1,0,0,0`), the coding
  scheme with each message (`AT+CSDH=1`), the network's time kept and its
  changes told (`AT+CTZU=1`, `AT+CTZR=1`);
- a URC arriving in another command's answer (RING, +CLIP, +CMTI, VOICE
  CALL: BEGIN/END, NO CARRIER, BUSY, NO ANSWER, the time-zone ones) is
  handled where it is read, never taken for the answer; a +CMTI only notes
  the slot, read and then deleted between commands;
- a UCS2 body (anything outside GSM-7: curly quotes, emoji) arrives as hex,
  told apart by the coding scheme; a message is sent as GSM-7 when it is
  plain ASCII, as UCS2 otherwise (`AT+CSCS="UCS2"` *and* `AT+CSMP`'s dcs
  8, the number in hex too, the defaults put back after), folded to ASCII
  as a last resort; `AT+CMGS` is ended by CR alone;
- `AT+CLCC` every 2 s while a call is up (the URCs alone do not reliably
  say when it ends);
- the network's time read with `AT+CCLK?` once registered and when the
  network says it moved.

Not kept: lilyphone1's UDP relay over the data context and its
notification tones.  New: the SIM's state (`AT+CPIN?`: no SIM, locked),
a RING told once its +CLIP has come (or half a second without), events for
the Phone transport-to-be (ring, connected, ended, busy, no answer).

**The natives** (`HostCellularNatives.cpp`, listed in `HostCellular.h`):
`HostCellAvailable`, `HostCellStatus`, `HostCellDial`, `HostCellAnswer`,
`HostCellHangUp`, `HostCellSendText`, `HostCellSendState`,
`HostCellNextText`, `HostCellNextEvent`, and `HostCellCommand(command)` -
a command sent as it is, for looking at what a module can do from the
board's NewtonScript prompt (`HostCellCommand("AT+CLAC")`).  `callState`,
not `call`: `call` is a NewtonScript reserved word.

**The desktop's module** is `tools/modem/fakecell.py` on `newton
--cell-port 0` (`HostCellularSocket.cpp`): the A76xx dialect above, with
commands of its own a script drives the far end with (`AT+FAKERING`,
`AT+FAKETEXT`, `AT+FAKEHANGUP`).  ctest `host.NewtonCellular`
(`src/host/demo/cellular.ns`): registered, a stored message picked up,
a call made and hung up, one refused busy, one rung in with caller ID,
answered and hung up by the far end, a message received with an emoji
(a surrogate pair) and two sent (GSM-7 and UCS2).  ctest `host.Cellular`
tests the parsing (UCS2, time stamps, +CMGR headers).

**The board** (`src/host/esp32/main/tdeck_modem.cpp`): UART1 at 115200
(our TX GPIO 10, RX GPIO 11), the module's supply GPIO 41 (an SGM6609
boost), its power key GPIO 40 - a button: a 50 ms press, as LilyGO's
`examples/A7682E/test_AT` gives it, and a second's press when that gets no
answer.  GPIO 7-9 (RI, DTR, RESET) are left alone.  The engine runs on a
task of the board's own (8 KB internal stack, core 0); its large buffers
are `HOST_LARGE_STATIC`.  The network's time sets the board's clock
(`HostDeviceClockSetTo`), and the Newton's follows as it does after SNTP.

What the board showed:

- **GPIO hold.** The supply pin is released from GPIO hold first
  (`gpio_hold_dis`): lilyphone1 latches its power pins for deep sleep, and
  a held pin outlasts a reset and ignores every write.
- **No battery, no module.** The SGM6609 boost that feeds the module runs
  from the battery: on USB power alone GPIO 41 reads high and the module
  stays dark (no LED, no answer).  The owner found this from the circuit.
- lilyphone1's own start is not what its comments say: its `setup()`
  drives the power key high early and holds it through the I2C scan and
  the display's start (seconds) before `A7682E_init`'s 50 ms pulse - the
  press that really starts the module there is the long one.

With the battery in (2026-10-12) the module answered at once, was
configured, registered on its home network (Optus, -77 dBm) and set the
board's clock from the network's time (zone +11 h).  Asked from the
board's NewtonScript prompt with `HostCellCommand`:

- `ATI`: Model A7682E, Revision A7682M7_V1.11.1, `+GCAP: +CGSM,+FCLASS,+DS`;
- `AT+FCLASS=?`: `+FCLASS: 8` - voice only, **no fax class**: a fax cannot
  go through the module (step 4 is an internet fax service, or nothing);
- `AT+CSDVC=?`: `(1,3)` - the audio to the handset or the speaker;
- `AT+COPS?` named the operator by its number ("50502") until the engine
  asked for names (`AT+COPS=3,0`).

## Open questions

- Whether a speaker and microphone are fitted to the module's audio pins
  (lilyphone1 never found out: it could only try `AT+CPTONE`).
- Whether `AT+CSCS="GSM"` loses the ASCII characters that differ in GSM-7
  (`@`, `$`, `_`): lilyphone1 says they survive; worth one test message.
