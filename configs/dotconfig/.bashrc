#       __               __                    __  ___________
#      / /_  ____ ______/ /_  __________      / /_<  / __/ __ \
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/_____/ //_/ / /_/ / / /
#  _ / /_/ / /_/ (__  ) / / / /  / /__/_____/ ,< / / __/ /_/ /
# (_)_.___/\__,_/____/_/ /_/_/   \___/     /_/|_/_/_/  \____/

# exports
export TERM="xterm-256color"
export PATH="$PATH:/home/$USER/.local/bin:/home/$USER/.cargo/bin"
export HISTCONTROL="erasedups:ignorespace"
export EDITOR="helix"
export VISUAL="helix"
export LESS='-R --use-color -Dd+r$Du+b'
export MANPAGER="less"
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# shopt
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend

# fix doas completion
complete -cf doas

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
alias ps='procs'
alias tree='eza -Tg@'
alias ls='eza -1g@'
alias ll='eza -g@lhUm'
alias la='eza -g@lahUm'
alias cat='bat --plain --style grid'
alias du='dust'
alias ip='ip -color=auto'
alias grep='rg'
alias df='df -h'
alias nano='helix'
alias top='htop'

# update aliases
alias mirup='doas reflector -p https -l 20 \
-c ch,at,de \
--sort rate -n 10 --verbose \
--save /etc/pacman.d/mirrorlist'
alias pacup='doas pacman -Syu'
alias aurup='paru -aSyu'
alias aurthird='paru --pkgbuilds -Sy'
alias flatup='flatpak update'

# git aliases
alias gta='git add'
alias gtc='git commit'
alias gtp='git push'
alias gtu='git pull'
alias gts='git status'
alias gtb='git branch'
alias gtcl='git clone'

# more aliases
alias whatislove='echo "baby don\`t hurt me, no more"'
alias identme='echo -e "You are:\n$(curl -s ident.me)"'
alias ybi2fa=\
'ykman oath accounts list | fzf -e | \
xargs -ro ykman oath accounts code | \
cut -d " " -f 3 | wl-copy -n && echo "Copied!"'
alias uphist='expac --timefmt="%F %T" "%l %n" | sort -n'
alias ytaudio=\
'yt-dlp -o "%(title)s.%(ext)s" -f bestaudio --restrict-filenames \
-x --audio-format mp3 --add-metadata'
alias ytvideo=\
'yt-dlp -o "%(title)s.%(ext)s" --restrict-filenames \
--recode-video mp4 --add-metadata'

# prompt
eval "$(starship init bash)"
