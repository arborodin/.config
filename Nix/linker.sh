# Shellscript to link NixOS configurations folder.

#!/bin/sh

chown -R +1000 /etc/nixos
ln -s /etc/nixos /home/"$USER"/.nix
