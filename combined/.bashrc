#       __               __                    __  ___________
#      / /_  ____ ______/ /_  __________      / /_<  / __/ __ \
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/_____/ //_/ / /_/ / / /
#  _ / /_/ / /_/ (__  ) / / / /  / /__/_____/ ,< / / __/ /_/ /
# (_)_.___/\__,_/____/_/ /_/_/   \___/     /_/|_/_/_/  \____/

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#exports
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

#aliases (req procs, exa, bat, fd)
alias ps="procs"
alias ls="exa -1g@"
alias ll="exa -1g@l"
alias la="exa -1g@a"
alias lla="exa -1g@la"
alias cat="bat --plain --style grid"
alias find="fd"

#get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 -c Austria,Switzerland,Italy --number 5 --verbose --save /etc/pacman.d/mirrorlist"

#remove orphans
alias cleanup='sudo pacman -Rs $(pacman -Qtdq)'

#clear pacman cache (req paru)
alias cleancache='sudo pacman -Scc && echo "Clearing paru cache..." && rm -rf ~/.cache/paru/clone/* && echo "Done!"'

#update AUR packages (req paru)
alias aurup='paru -aSyu'

#update Flatpak packages (req flatpak)
alias flatup='flatpak update'

#updategpg keys
alias gpgup='gpg --refresh-keys --keyserver hkps://keys.openpgp.org'

#typos
alias pdw="pwd"
alias chwon="chown"
alias udo="sudo"
alias sduo="sudo"

#git aliases
alias gtc="git status"
alias gta="git add"
alias gtc="git commit"
alias gtp="git push"
alias gtu="git pull"

#more aliases
alias yt2audio="youtube-dl -f bestaudio"
alias pingscan="nmap -sP"
alias netscan="nmap -sV"
alias whatislove='echo "baby don\`t hurt me"'

#prompt
CURSIVE="\[\e[3m\]"
BOLD="\[\e[1m\]"
CROSSED="\[\e[9m\]"
COLOR="\[\e[02;35m\]"
END="\[\e[0m\]"
PS1="${BOLD}${CURSIVE}${COLOR}\W${END} > "


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
