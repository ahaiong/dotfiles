# .bash_profile

# keeping it all in one file for simplicity
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -e /Users/aong/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/aong/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
