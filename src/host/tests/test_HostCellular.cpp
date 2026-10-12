// The cellular engine's parsing (host/HostCellular.h): UCS2 message bodies
// to and from UTF-8, the module's time stamps, and +CMGR's header - each
// against a line as the A7682E gives it (lilyphone1's notes) or a value
// worked out by hand.  The engine's conversation with a module is
// tools/modem/fakecell.py's (ctest host.NewtonCellular).

#include "HostCellular.h"

#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)


static void
TestUCS2()
{
	char out[128];
	EXPECT(HostCellularUCS2ToUTF8("004C0069006B00650064", out, sizeof(out)) && strcmp(out, "Liked") == 0);
	// a curly quote (U+201C), an e acute (U+00E9), and an emoji above the
	// BMP (U+1F600) as its surrogate pair
	EXPECT(HostCellularUCS2ToUTF8("201C00E9D83DDE00", out, sizeof(out)) && strcmp(out, "\xE2\x80\x9C\xC3\xA9\xF0\x9F\x98\x80") == 0);
	EXPECT(!HostCellularUCS2ToUTF8("004", out, sizeof(out)));			// not a whole unit
	EXPECT(!HostCellularUCS2ToUTF8("DE00", out, sizeof(out)));			// a trailing surrogate alone
	EXPECT(!HostCellularUCS2ToUTF8("D83D0041", out, sizeof(out)));		// a leading one without its pair
	EXPECT(!HostCellularUCS2ToUTF8("00G1", out, sizeof(out)));

	EXPECT(HostCellularUTF8ToUCS2("Hi", out, sizeof(out)) && strcmp(out, "00480069") == 0);
	EXPECT(HostCellularUTF8ToUCS2("\xE2\x80\x9C\xF0\x9F\x98\x80", out, sizeof(out)) && strcmp(out, "201CD83DDE00") == 0);
	EXPECT(HostCellularUTF8ToUCS2("+61412345678", out, sizeof(out)) && strcmp(out, "002B00360031003400310032003300340035003600370038") == 0);
	EXPECT(!HostCellularUTF8ToUCS2("\xC3", out, sizeof(out)));			// cut short
	EXPECT(!HostCellularUTF8ToUCS2("abcdef", out, 9));					// no room

	// a round trip
	char back[128];
	const char* text = "caf\xC3\xA9 \xE2\x80\x94 \xF0\x9F\x91\x8D";
	EXPECT(HostCellularUTF8ToUCS2(text, out, sizeof(out)) && HostCellularUCS2ToUTF8(out, back, sizeof(back)) && strcmp(back, text) == 0);
}


static void
TestStamps()
{
	long long seconds;
	long offset;
	bool hasOffset;
	// 2025-09-04 10:22:33 at UTC+10 (+40 quarter hours) is 00:22:33 UTC:
	// 20335 days after 1970-01-01
	EXPECT(HostCellularParseStamp("25/09/04,10:22:33+40", &seconds, &offset, &hasOffset));
	EXPECT(seconds == 20335LL * 86400 + 22 * 60 + 33 && offset == 600 && hasOffset);
	// across midnight backwards: 2025-01-01 05:00 at UTC+9:30 (+38) is
	// 2024-12-31 19:30 UTC
	EXPECT(HostCellularParseStamp("25/01/01,05:00:00+38", &seconds, &offset, &hasOffset));
	EXPECT(seconds == 20088LL * 86400 + 19 * 3600 + 30 * 60 && offset == 570);
	// west of Greenwich
	EXPECT(HostCellularParseStamp("26/10/12,08:00:00-28", &seconds, &offset, &hasOffset));
	EXPECT(offset == -420 && seconds == 20738LL * 86400 + 15 * 3600);
	// no zone given
	EXPECT(HostCellularParseStamp("26/10/12,08:00:00", &seconds, &offset, &hasOffset));
	EXPECT(!hasOffset && offset == 0 && seconds == 20738LL * 86400 + 8 * 3600);
	EXPECT(!HostCellularParseStamp("garbage", &seconds, &offset, &hasOffset));
	EXPECT(!HostCellularParseStamp("26/13/12,08:00:00", &seconds, &offset, &hasOffset));
}


static void
TestCMGR()
{
	char number[32], stamp[40];
	long dcs;
	// with AT+CSDH=1: <tooa>,<fo>,<pid>,<dcs> after the stamp, then the
	// service centre's number quoted
	HostCellularParseCMGR("+CMGR: \"REC UNREAD\",\"+61412345678\",,\"25/09/04,10:22:33+40\",145,4,0,8,\"+61418706700\",145,7",
						  number, sizeof(number), stamp, sizeof(stamp), &dcs);
	EXPECT(strcmp(number, "+61412345678") == 0 && strcmp(stamp, "25/09/04,10:22:33+40") == 0 && dcs == 8);
	// the sender in the SIM's phone book: an <alpha> quoted before the stamp
	HostCellularParseCMGR("+CMGR: \"REC READ\",\"+61412345678\",\"Mum\",\"25/09/04,10:22:33+40\",145,4,0,0,\"+61418706700\",145,5",
						  number, sizeof(number), stamp, sizeof(stamp), &dcs);
	EXPECT(strcmp(number, "+61412345678") == 0 && strcmp(stamp, "25/09/04,10:22:33+40") == 0 && dcs == 0);
	// without AT+CSDH: no coding scheme
	HostCellularParseCMGR("+CMGR: \"REC READ\",\"+61412345678\",,\"25/09/04,10:22:33+40\"",
						  number, sizeof(number), stamp, sizeof(stamp), &dcs);
	EXPECT(strcmp(stamp, "25/09/04,10:22:33+40") == 0 && dcs == -1);
}


int
main()
{
	TestUCS2();
	TestStamps();
	TestCMGR();
	if (failures == 0)
		printf("test_HostCellular: all passed\n");
	return failures == 0 ? 0 : 1;
}
