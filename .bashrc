# .bashrc

# Lets have an infinite history
HISTSIZE=""

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; else curl https://nixos.org/nix/install | sh; fi # added by Nix installer
