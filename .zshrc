export PATH=$HOME/bin:$HOME/Android/Sdk/platform-tools:$HOME/Apps/android-studio/bin:$HOME/Apps/Matlab/bin:$HOME/Scripts:$PATH
export ZSH="/home/alex/.oh-my-zsh"

ZSH_THEME="aleNix"

plugins=(
  git
  sudo
)

source $ZSH/oh-my-zsh.sh

alias dvpn='nmcli c u DiracVPN'
alias spatial='cd ~/Repos/libspatial/'
