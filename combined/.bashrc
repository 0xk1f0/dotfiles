#       __               __                    __  ___________
#      / /_  ____ ______/ /_  __________      / /_<  / __/ __ \
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/_____/ //_/ / /_/ / / /
#  _ / /_/ / /_/ (__  ) / / / /  / /__/_____/ ,< / / __/ /_/ /
# (_)_.___/\__,_/____/_/ /_/_/   \___/     /_/|_/_/_/  \____/

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# exports
export TERM="xterm-256color"
export PATH="$PATH:/home/k1f0/.local/bin"

# archive extraction
extr () {
  if [ -z "$1" ] ; then
    echo "no input"
  elif [ -f "$1" ] ; then
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
      *)           echo "'$1': unsupported filetype" ;;
    esac
  else
    echo "'$1': invalid"
  fi
}

# to encr-archive
ncryptArch() {
  if [ -n "$1" ]; then
    read -esp "Enter Passphrase: " pass
    tar -czf - $1 | gpg -c --cipher-algo AES256 --s2k-digest-algo SHA512 \
    --s2k-count 100000 --no-symkey-cache \
    --passphrase $pass --batch > $(echo $1 | tr -d '/').tar.gz.gpg
  else
    echo "No Input"
  fi
}

# encr-archive decryption
dcryptArch() {
  if [ -n "$1" ]; then
    read -esp "Enter Passphrase: " pass
    gpg -d --no-symkey-cache --passphrase $pass --batch $1 | tar -xzf -
  else
    echo "No Input"
  fi
}

# base replacement aliases
alias ps="procs"
alias tree="exa -Tg@"
alias ls="exa -1g@"
alias ll="exa -g@lhUm"
alias la="exa -1g@a"
alias lla="exa -g@lahUm"
alias cat="bat --plain --style grid"
alias find="fd -p"
alias du="dust"
alias grep="rg"

# update aliases
alias mirup="doas reflector -f 20 -l 20 -c ch,at,de -n 20 --verbose --save /etc/pacman.d/mirrorlist"
alias pacup='doas pacman -Syu'
alias aurup='paru -aSyu'
alias flatup='flatpak update'
alias gpgup='gpg --refresh-keys --keyserver hkps://keys.openpgp.org'

# git aliases
alias gts="git status"
alias gta="git add"
alias gtc="git commit"
alias gtp="git push"
alias gtu="git pull"
alias gtcl="git clone"

# more aliases (req youtube-dl, nmap)
alias yt2audio="youtube-dl -f bestaudio"
alias whatislove='echo "baby don\`t hurt me"'
alias identme='echo -e "You are:\n$(curl -s ident.me)"'

# prompt
eval "$(starship init bash)"
