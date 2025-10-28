### PATH CONFIGURATION ###
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/.config/composer/vendor/bin $HOME/Applications /var/lib/flatpak/exports/bin/ ~/.npm-global/bin $fish_user_paths

### ENVIRONMENT ###
set fish_greeting                    # Suppress fish's intro message
set TERM "xterm-256color"           # Terminal type

### KEY BINDINGS ###
function fish_user_key_bindings
    fish_vi_key_bindings
end

# History shortcuts for vi mode
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

### COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### NAVIGATION ALIASES ###
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

### ENHANCED NAVIGATION ###
function zd
    if test (count $argv) -eq 0
        builtin cd ~
        return
    else if test -d "$argv[1]"
        builtin cd "$argv[1]"
    else
        z $argv && printf " \u17A9 " && pwd || echo "Error: Directory not found"
    end
end

alias cd="zd"

### SYSTEM UTILITIES ###
function open
    xdg-open $argv >/dev/null 2>&1 &
end

### PACKAGE MANAGEMENT ###
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

### LARAVEL/PHP DEVELOPMENT ###
mise activate fish | source
alias pa='php artisan'
alias mfs='pa migrate:fresh --seed'
alias sail='./vendor/bin/sail'

### GIT ALIASES ###
alias gaa='git add .'
alias commit='git add . && git commit -m'
alias gc='git checkout'
alias gcm='git checkout main'
alias pull='git pull origin'
alias push='git push'
alias pusho='git push -u origin'
alias wip='commit wip && push'

### FILE MANAGEMENT ###
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

### GREP WITH COLOR ###
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

### TMUXINATOR ###
alias mux="tmuxinator"
alias muxs="tmuxinator start"
alias muxe="tmuxinator edit"

### DISK MANAGEMENT ###
alias disk1='udisksctl mount -b /dev/sda1'
alias disk2='udisksctl mount -b /dev/sda2'

### SHELL SWITCHING ###
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

### HISTORY FUNCTIONS ###
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
#
#colorscript random

### LAUNCH HYPRLAND ###
if status is-login; and test (tty) = /dev/tty1
    exec hyprland
end

### INIT ZOXIDE ###
zoxide init fish | source

### STARSHIP PROMPT ###
starship init fish | source
