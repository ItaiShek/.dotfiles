## General info
This is a bare GitHub repository for organizing my dotfiles.
<br>
**You should not run this script!** If you do then your system configurations, desktop, window manager, terminal, etc will look like mine.


### Installation
```
git clone --bare https://github.com/ItaiShek/.dotfiles.git $HOME/.dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' >> $HOME/.bashrc
dots checkout -f
$HOME/.dotfiles/dotfiles.sh -i
dots config --local status.showUntrackedFiles no
```
