# PlatformIO extra script (platformio.ini): the baked ROM objects written to
# their partition (partitions.csv, "objects" at 0x610000) with every upload,
# when the image is there - src/host/esp32/objects.baked, or the file
# NEWTON_BAKED_IMAGE names.  src/host/esp32/README.md says how it is baked:
# by the 32-bit build, at the address the board maps the partition at.
Import("env")
import os

image = os.environ.get("NEWTON_BAKED_IMAGE") or os.path.join(env.subst("$PROJECT_DIR"), "objects.baked")
if os.path.isfile(image):
    env.Append(FLASH_EXTRA_IMAGES=[("0x610000", image)])
    print("newton: the baked ROM objects %s go to 0x610000" % image)
else:
    print("newton: no baked ROM objects (%s) - the board boots without them" % image)
