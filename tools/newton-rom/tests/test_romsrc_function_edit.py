#!/usr/bin/env python3
"""Edits to a function that move its literals (ctest tools.ROMSourceFunctionEdit).

    python tools/newton-rom/tests/test_romsrc_function_edit.py --newtonscript <newtonscript>

A `same("...")` definition and the layout's alias lines name an object by
the path a compiled function holds it at (`...literals[3]`); an edit to the
function can move its literals.  The builder (romsrc.py) takes the object
from wherever a compiled function holds it - the same() path or any alias
line's - and finds a moved literal's alias by its contents, so neither
needs mending by hand.  Internet Setup (romsrc/rex/inetstup) is the case:
its edit slip's viewSetupFormScript was changed for the T-Deck Pro, which
moved the walk-through bounds function it shares with four others from
literals[3] to literals[1].

- With the same() and the alias put back as they were before that edit,
  the package builds to the committed tree's bytes.
- With the edit slip no longer using the function at all, it still
  builds, the four others sharing its one copy.
Temporary files go under the repository's tmp/.
"""

import os
import re
import shutil
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools", "newton-rom", "analysis"))
sys.path.insert(0, os.path.join(ROOT, "tools", "armpart"))
import romsrc			# noqa: E402
import newtonpkg		# noqa: E402

NEWTONSCRIPT = None
TREE = os.path.join(ROOT, "romsrc", "rex", "inetstup")
WORK = os.path.join(ROOT, "tmp", "romsrc-function-edit")
SAME = 'obj_100f7a1 := same("%s");'
NOW = "obj_10002d1[0].theForm.viewSetupFormScript.literals[6]"
BEFORE = "obj_10002d1[0].theForm.editSlip.viewSetupFormScript.literals[3]"
ALIAS = "alias\tobj_10002d1[0].theForm.editSlip.viewSetupFormScript.literals[%d]\tobj_100f7a1"
SLIP = "obj_10002d1_0_.theForm.editSlip.viewSetupFormScript.ns"


def edit(path, old, new):
	with open(path, encoding="utf-8", newline="") as f:
		text = f.read()
	nl = "\r\n" if "\r\n" in text else "\n"
	old, new = old.replace("\n", nl), new.replace("\n", nl)
	assert text.count(old) == 1, (path, old)
	with open(path, "w", encoding="utf-8", newline="") as f:
		f.write(text.replace(old, new))


class FunctionEdit(unittest.TestCase):
	@classmethod
	def setUpClass(cls):
		if NEWTONSCRIPT is None:
			raise unittest.SkipTest("--newtonscript is needed (the trees' functions are compiled)")
		cls.trees = romsrc.PackageTrees(os.path.abspath(NEWTONSCRIPT))
		cls.committed = newtonpkg.pack(TREE, trees=cls.trees)

	def copy(self, name):
		where = os.path.join(WORK, name)
		shutil.rmtree(where, ignore_errors=True)
		shutil.copytree(TREE, where)
		return where

	def test_paths_from_before_the_edit(self):
		tree = self.copy("before")
		edit(os.path.join(tree, "part0", "objects", "obj_10002d1.ns"), SAME % NOW, SAME % BEFORE)
		edit(os.path.join(tree, "part0", "layout.tsv"), ALIAS % 1, ALIAS % 3)
		self.assertEqual(newtonpkg.pack(tree, trees=self.trees), self.committed)

	def test_function_no_longer_used_there(self):
		tree = self.copy("unused")
		edit(os.path.join(tree, "part0", "objects", "obj_10002d1.ns"), SAME % NOW, SAME % BEFORE)
		edit(os.path.join(tree, "part0", "layout.tsv"), ALIAS % 1, ALIAS % 3)
		edit(os.path.join(tree, "part0", "functions", SLIP), "\tself.viewBounds := call (kFunction_100f7a1) with ();",
			 "\tself.viewBounds := SetBounds(0, -200, 200, -8);")
		with open(os.path.join(tree, "part0", "functions", SLIP), encoding="utf-8") as f:
			slip = f.read()
		# (the function's own copy of the constant goes too: nothing uses it)
		slip = re.sub(r"@@const kFunction_100f7a1\n.*?(?=@@main)", "", slip, flags=re.S)
		slip = slip.replace("@@main\n", "") if "@@const" not in slip else slip
		with open(os.path.join(tree, "part0", "functions", SLIP), "w", encoding="utf-8", newline="\n") as f:
			f.write(slip)
		data = newtonpkg.pack(tree, trees=self.trees)
		self.assertNotEqual(data, self.committed)
		pkg, blobs = newtonpkg.read(data)
		self.assertEqual(len(blobs), 6)
		# the shared function laid out once: its instructions are in the
		# part one time, the four other functions holding the same object
		b = romsrc.Builder(os.path.join(tree, "part0"), os.path.abspath(NEWTONSCRIPT), relayout=True)
		b.build()
		shared = b.defs["obj_100f7a1"]
		code = shared.items[shared.tags.index("instructions")]
		copies = [v for v in b.by_path.values() if v.kind == "frame" and "instructions" in v.tags
				  and getattr(v.items[v.tags.index("instructions")], "data", None) == getattr(code, "data", code)]
		self.assertEqual(len(copies), 1)


if __name__ == "__main__":
	if "--newtonscript" in sys.argv:
		i = sys.argv.index("--newtonscript")
		NEWTONSCRIPT = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
