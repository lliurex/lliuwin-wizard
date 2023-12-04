# Lliuwin's User Wizard

Config wizard for lliuwin.

Manual install:
 * The img must be configured to autostart the default session
 * autostart-scripts: Script that launches the wizard at startup (deprecated)
 * autostart: Desktop for launch at startup
 * src: The wizard itself
 * rsrc: images
 * polkit: Action and rule for adduser

LliureX install:
 * Chroot into the image and install this package. Lliuwin user will be created if needed and sddm configured with autologin enabled. The package will install the autostart desktop in /home/lliuwin/.config/autostart.
