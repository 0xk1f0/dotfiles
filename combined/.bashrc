#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#color
export TERM="xterm-256color"
export PATH="$PATH:/home/k1f0/.local/bin"

#archive extraction
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"    && echo "done" ;;
      *.tar.gz)    tar xzf "$1"    && echo "done" ;;
      *.bz2)       bunzip2 "$1"    && echo "done" ;;
      *.rar)       unrar x "$1"    && echo "done" ;;
      *.gz)        gunzip "$1"     && echo "done" ;;
      *.tar)       tar xf "$1"     && echo "done" ;;
      *.tbz2)      tar xjf "$1"    && echo "done" ;;
      *.tgz)       tar xzf "$1"    && echo "done" ;;
      *.zip)       unzip "$1"      && echo "done" ;;
      *.Z)         uncompress "$1" && echo "done" ;;
      *.7z)        7z x "$1"       && echo "done" ;;
      *.deb)       ar x "$1"       && echo "done" ;;
      *.tar.xz)    tar xf "$1"     && echo "done" ;;
      *.tar.zst)   unzstd "$1"     && echo "done" ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#use new rust programs for these commands (req procs, exa, bat)
alias ps="procs"
alias ls="exa -1"
alias cat="bat --plain --style grid"
alias nv="neovide"

#get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 -c Switzerland,Italy --number 5 --verbose --save /etc/pacman.d/mirrorlist"

#remove orphans
alias cleanup='sudo pacman -Rs $(pacman -Qtdq)'

#clear pacman cache (req paru)
alias cleancache='sudo pacman -Scc && echo "Clearing paru cache..." && rm -rf ~/.cache/paru/clone/* && echo "Done!"'

#update AUR packages (req paru)
alias aurup='paru -a -Syu'

#updategpg keys
alias gpgup='gpg --refresh-keys --keyserver hkps://keys.openpgp.org'

#typos
alias pdw="pwd"

#prompt
PS1='\[\033[01;36m\]\W\[\033[01;37m\] >\[\033[00;37m\] '
