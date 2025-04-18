#       __               __                    __  ___________
#      / /_  ____ ______/ /_  __________      / /_<  / __/ __ \
#     / __ \/ __ `/ ___/ __ \/ ___/ ___/_____/ //_/ / /_/ / / /
#  _ / /_/ / /_/ (__  ) / / / /  / /__/_____/ ,< / / __/ /_/ /
# (_)_.___/\__,_/____/_/ /_/_/   \___/     /_/|_/_/_/  \____/

# base exports
export TERM="xterm-256color"
export HISTCONTROL="erasedups:ignorespace"
export EDITOR="helix"
export VISUAL="helix"
export LESS='-R --use-color -Dd+r$Du+b'
export MANPAGER="less"

# custom exports
export ANDROID_HOME="/home/$USER/.android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_SDK_HOME="$ANDROID_HOME"

# path exports
export PATH="$PATH:$(ls -d $ANDROID_HOME/build-tools/*/ | sort -V | tail -n 1)"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="$PATH:/home/$USER/.cargo/bin"

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# shopt
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend

# archive extraction
extr () {
  if [ -z "$1" ] ; then
    echo "Missing argument"
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
    echo "Invalid argument"
  fi
}

# encrypt folder to archive
gncrypt() {
  if [ -n "${1}" ]; then
    read -esp "Enter Passphrase: " p
    tar -czf - "${1}" | gpg -c --cipher-algo AES256 \
    --s2k-digest-algo SHA512 --s2k-count 100000 --no-symkey-cache \
    --passphrase "${p}" --batch > $(basename "${1}").tar.gz.gpg
  else
    echo "Missing argument"
  fi
}

# decrypt archive to folder
gdcrypt() {
  if [ -n "${1}" ]; then
    read -esp "Enter Passphrase: " p
    gpg -d --no-symkey-cache --passphrase "${p}" \
    --batch "${1}" | tar -xzf -
  else
    echo "Missing argument"
  fi
}

# cut media to bounds
ffmcut() {
  if [ -n "${1}" ] && [ -n "${2}" ] && [ -n "${3}" ]; then
    ffmpeg -i "${1}" -ss "${2}" -to "${3}" -c:v copy -c:a copy "cut_${1}"
  else
    echo "Missing arguments"
  fi
}

# trim metadata from media
ffmtrim() {
  if [ -n "${1}" ]; then
    ffmpeg -i "${1}" -map 0 -map_metadata -1 -c copy "trim_${1}"
  else
    echo "Missing argument"
  fi
}

# base replacement aliases
alias ps='procs'
alias tree='eza -Tg@'
alias ls='eza -1g@'
alias ll='eza -g@lhUm'
alias la='eza -g@lahUm'
alias cat='bat --theme base16 --plain --style plain'
alias du='dust'
alias ip='ip -color=auto'
alias grep='rg'
alias df='df -h'
alias nano='helix'
alias top='htop'
alias sudo='sudo-rs'
alias su='su-rs'
alias amd-smi="amdgpu_top --smi"

# update aliases
alias mirup='reflector -p https -l 20 \
-c ch,at,de \
--sort rate -n 10 --verbose | \
wl-copy -n && echo "Copied!"'
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
alias identme='echo -e "You are:\n$(curl -s a.ident.me)"'
alias ybi2fa=\
'ykman oath accounts list | fzf --margin=25% --border | \
xargs -rod "\n" ykman oath accounts code | \
cut -d ":" -f 2 | cut -d " " -f 3 | \
wl-copy -n && echo -e "\n> $(wl-paste) <"'
alias uphist='expac --timefmt="%F %T" "%l %n" | sort -n'
alias ytaudio=\
'yt-dlp -o "%(title)s.%(ext)s" -f bestaudio --restrict-filenames \
-x --audio-format mp3 --add-metadata'
alias ytvideo=\
'yt-dlp -o "%(title)s.%(ext)s" --restrict-filenames \
--recode-video mp4 --add-metadata'

# prompt
eval "$(starship init bash)"
