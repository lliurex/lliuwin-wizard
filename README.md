# Lliuwin's User Wizard

Config wizard for lliuwin.

It's simple:
 * The img must be configured to autostart the default session
 * autostart-scripts: Script that launches the wizard at startup
 * src: The wizard itself
 * rsrc: images
 * polkit: Action and rule for adduser

Chroot to the image, install this package and put the autostart-scripts at default user's autostart folder.
