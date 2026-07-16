# Shellscript to link NixOS configurations folder.

#!/bin/sh

sudo chown -R +1000 /etc/nixos
ln -sfn /etc/nixos /home/"$USER"/.nix
