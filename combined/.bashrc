#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#color
export TERM="xterm-256color"

#archive extraction
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1    && echo "done" ;;
      *.tar.gz)    tar xzf $1    && echo "done" ;;
      *.bz2)       bunzip2 $1    && echo "done" ;;
      *.rar)       unrar x $1    && echo "done" ;;
      *.gz)        gunzip $1     && echo "done" ;;
      *.tar)       tar xf $1     && echo "done" ;;
      *.tbz2)      tar xjf $1    && echo "done" ;;
      *.tgz)       tar xzf $1    && echo "done" ;;
      *.zip)       unzip $1      && echo "done" ;;
      *.Z)         uncompress $1 && echo "done" ;;
      *.7z)        7z x $1       && echo "done" ;;
      *.deb)       ar x $1       && echo "done" ;;
      *.tar.xz)    tar xf $1     && echo "done" ;;
      *.tar.zst)   unzstd $1     && echo "done" ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#use new rust programs for these commands (req procs, exa, bat)
alias ps="procs"
alias ls="exa -l"
alias cat="bat"

#put system to sleep
alias suspendsystem="systemctl suspend && betterlockscreen -l"

#get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 15 --verbose --save /etc/pacman.d/mirrorlist"

#start ssh agent and add keys
alias startssh='eval `ssh-agent -s` && ssh-add ~/git/.keystore/github_rsa'

#remove orphans
alias cleanup='sudo pacman -Rs $(pacman -Qtdq)'

#clear pacman cache (req paru)
alias cleancache='paru -Scc'

#update AUR packages (req paru)
alias aurup='paru -a -Syu'

#updategpg keys
alias gpgup='gpg --refresh-keys --keyserver hkps://keys.openpgp.org'

#typos
alias pdw="pwd"

#prompt
#PS1='\[\033[34m\]┌─[\[\033[37m\]\u@\h\[\033[34m\]]─[\[\033[37m\]\W\[\033[34m\]]─[\[\033[37m\]\A\[\033[34m\]]\n\[\033[34m\]└─> \[\033[37m\]'
PS1='\[\033[37m\]\[\033[36m\]\W\[\033[35m\] >\[\033[37m\] '

#custom start thingies
echo
PF_INFO="ascii title os kernel pkgs uptime wm " /usr/bin/pfetch 