# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
printf '\n%.0s' {1..130}

### p10k onedark_saturated theme ###
function _set_palette() {
  local -a colors=(
    "000000"  # 0  Black
    "f42340"  # 1  Red
    "5ddd44"  # 2  Green
    "f0b030"  # 3  Yellow
    "2090f5"  # 4  Blue
    "cc22e8"  # 5  Magenta
    "0dccd8"  # 6  Cyan
    "abb2bf"  # 7  White
    "434852"  # 8  Bright Black
    "ff6070"  # 9  Bright Red
    "7ef06e"  # 10 Bright Green
    "ffd060"  # 11 Bright Yellow
    "60b8ff"  # 12 Bright Blue
    "e040f5"  # 13 Bright Magenta
    "20e8f5"  # 14 Bright Cyan
    "c8cdd5"  # 15 Bright White
  )
  local i=0
  for hex in "${colors[@]}"; do
    printf '\e]4;%d;#%s\a' "$i" "$hex"
    (( i++ ))
  done
  printf '\e]10;#abb2bf\a'  # foreground
  printf '\e]11;#000000\a'  # background
  printf '\e]12;#ffffff\a'  # cursor
  printf '\e]19;#cc22e8\a'  # selection background
  printf '\e]17;#abb2bf\a'  # selection foreground
}
_set_palette


####################################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/rvm/scripts/rvm

export LANG=en_US.UTF-8

# History search (MacOS-style)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "${key[Up]}"   up-line-or-beginning-search
bindkey "${key[Down]}" down-line-or-beginning-searc
