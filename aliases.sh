# some more ls aliases
alias ls='lsd --group-dirs first'
alias ll='ls -lh'
alias la='ls -A'
#alias l='ls -CF'
alias l='lsd -ah --group-dirs first'
#alias lx='ls -a'
alias radio='pmrp'
alias imagen='~/scripts/imagenes.sh'
alias mount='mount | column -t'
alias diff='colordiff'
alias puertos='netstat -tulanp'
alias uu='sudo apt update && sudo apt upgrade'
alias permisos='~/scripts/chmod.sh'
alias contraseña="openssl rand -base64 20"
alias grupos='column /etc/group -t -s ":" | less -R | column'
alias usuarios='column /etc/passwd -t -s ":"'
alias tarball='sudo ~/scripts/tarball.sh'
alias list="lsd -lah --group-dirs first"
alias pantalla='xrandr'
alias noticias='newsboat'
alias df='df -h'
alias ping='ping google.com -c 5'
alias menu='sudo ~/menu2.sh'
alias free='free -h'
alias du='du -h'
alias enlaces='ls -la | grep "\->"'
alias pstop='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
alias reloadu='source ~/.bashrc'
alias calculadora='bc'
alias quemadorDiscoOptico='cdw'
alias instalado='apt list --installed | grep '
alias x='exit'
alias th='tmux split-window -v'
alias tv='tmux split-window -h'
alias tm='if tmux has; then tmux attach; else tmux new; fi'
alias vbash='vi  ~/.bashrc'
#alias bq='ls -la $1*'
alias bq='sudo find | fzf -i'

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}




#apt-get
alias agu="apt-get update"
alias agd="apt-get dist-upgrade"
alias agc="apt-get clean"
alias ag="apt-get update;apt-get dist-upgrade"
alias aga="apt-get autoremove"

#apt
alias au="sudo apt update"
alias ad="apt dist-upgrade -V"
alias ac="sudo apt clean"
alias aud="apt update;apt dist-upgrade -V"
alias aa="sudo apt autoremove"

alias e="cd /etc && lsd -ah --group-dirs first"
alias ..="cd .. && lsd -ah --group-dirs first"
alias b="cd /usr/bin"
alias tareas="calcurse"
alias cfg="cd  ~/.config/ && lsd --group-dirs first"
alias s="cd ~/scripts/ && lsd --group-dirs first"
alias wallpaper="cd /usr/share/wallpaper/ && lsd --group-dirs first"
alias comun="cd /usr/share && lsd --group-dirs first"
alias log="cd /var/log && lsd -ah --group-dirs first"
alias ip_publica="~/scripts/ip2.sh"
alias tiempo="~/scripts/tiempo.sh"
alias h="history"
alias navegador_texto='~/scripts/navegador_texto.sh'
alias hojaCalculo='sc'
alias lanzador="app-select"
alias dev="cd /dev && lsd -ah --group-dirs first"
alias fuentes="cd /etc/apt/sources.list.d/ && ls"
alias ra="sudo ranger"
#alias rm='sudo rm -r -I'
alias v='sudo vim'
alias dependencias='ldd'
#alias cp='cd -r'
