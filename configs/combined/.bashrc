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
      *.tar.bz2)   tar xjf "$1" ;;
      *.tar.gz)    tar xzf "$1" ;;
      *.bz2)       bunzip2 "$1" ;;
      *.rar)       unrar x "$1" ;;
      *.gz)        gunzip "$1"  ;;
      *.tar)       tar xf "$1"  ;;
      *.tbz2)      tar xjf "$1" ;;
      *.tgz)       tar xzf "$1" ;;
      *.zip)       unzip "$1"   ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1" ;;
      *.deb)       ar x "$1" ;;
      *.tar.xz)    tar xf "$1" ;;
      *.tar.zst)   unzstd "$1" ;;
      *)           echo "'$1': no alias" ;;
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
alias la="exa -g@lahUm"
alias cat="bat --plain --style grid"
alias find="fd -p"
alias du="dust"
alias grep="rg"

# update aliases
alias mirup="doas reflector -p https -f 20 -l 20 \
-c ch,at,de -n 20 --verbose --save /etc/pacman.d/mirrorlist"
alias pacup='doas pacman -Syu'
alias aurup='paru -aSyu'
alias flatup='flatpak update'

# git aliases
alias gts="git status"
alias gta="git add"
alias gtc="git commit"
alias gtp="git push"
alias gtu="git pull"
alias gtcl="git clone"

# more aliases
alias whatislove='echo "baby don\`t hurt me"'
alias identme='echo -e "You are:\n$(curl -s ident.me)"'
alias fdpkg="pacman -Ss | paste -d '' - - | \
fzf -e --multi --preview 'pacman -Si {1}' | \
cut -d ' ' -f 1 | xargs -ro doas pacman -S"
alias ybi2fa=\
"ykman oath accounts list | fzf -e | \
xargs -ro ykman oath accounts code | \
cut -d ' ' -f 3 | wl-copy -n && echo 'Copied!'"

# prompt
eval "$(starship init bash)"
