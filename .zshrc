# █████╗ ███╗   ██╗██████╗ ██████╗ ██╗███████╗██╗     
#██╔══██╗████╗  ██║██╔══██╗██╔══██╗██║██╔════╝██║     
#███████║██╔██╗ ██║██║  ██║██████╔╝██║█████╗  ██║     
#██╔══██║██║╚██╗██║██║  ██║██╔══██╗██║██╔══╝  ██║     
#██║  ██║██║ ╚████║██████╔╝██║  ██║██║███████╗███████╗
#╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝                                                    
#!/usr/bin/env zsh


# ========== 1) Exports & Environment Variables ==========
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$JAVA_HOME/bin:$PATH

# Path to your Oh My Zsh installation if installed using curl.
export ZSH="$HOME/.oh-my-zsh"

# Path to your oh-my-zsh installation if installed zsh using pacman.
#ZSH=/usr/share/oh-my-zsh/

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0c6a5,fg+:#efead9,bg:-1,bg+:#25262C
  --color=hl:#fb982e,hl+:#dd4e21,info:#d0c6a5,marker:#ffd072
  --color=prompt:#fb982e,spinner:#52a260,pointer:#cd80b9,header:#9cd750
  --color=gutter:#25262c,border:#878080,label:#d0c6a5,query:#efead9:regular
  --color=disabled:#404146
  --border="sharp" --border-label="" --preview-window="border-rounded" --prompt="» "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null; then
   export aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   export aurhelper="paru"
fi

# ========== 2) Plugin Managers & Sourcing ==========

source $ZSH/oh-my-zsh.sh

# nvm
source /usr/share/nvm/init-nvm.sh
# autoiint completions
autoload -Uz compinit

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light ohmyzsh/ohmyzsh

# powerlevel10k
#zinit ice depth=1; zinit light romkatv/powerlevel10k

# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.omp.toml)"

# startship
# eval "$(starship init zsh)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::bun
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zi snippet OMZ::lib/clipboard.zsh
zi snippet OMZ::lib/termsupport.zsh
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Shell integrations
eval "$(atuin init zsh)"
eval "$(fzf --zsh)"

if [ -z "$DISABLE_ZOXIDE" ]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# Aliases
alias ls='eza --icons --color=auto --sort=type --group-directories-first --header --classify --modified --created --git --binary --group'
alias vim='nvim'
alias kvim='NVIM_APPNAME=KickstartNvim nvim'
alias c='clear'
alias lz='lazygit'
# Use advcpmv with progress bar
alias cp='/usr/local/bin/cpg -g'
alias mv='/usr/local/bin/mvg -g'


# Package Management Aliases
alias un='$aurhelper -Rns' # uninstall package
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias pcc='$aurhelper -Scc' # full clean cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages
alias po2='$aurhelper -Qqd | $aurhelper -Rsu --print -pokemon-colorscripts' # testing

# Powerpill Update Aliases
alias up='update-system' # Full system update (powerpill + AUR helper)
alias ups='$aurhelper -Syu --noconfirm --removemake --cleanafter' # awesome update
alias upa='$aurhelper -Syu' # Update only AUR packages

# ASCII ART aliases
alias shark='display3d ~/.config/display3d/blahaj.obj -t 0,0,5.5'

# cleaning up home folder
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CONFIG_DIR="${XDG_CONFIG_DIR:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-$HOME/Templates}"
XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"
LESSHISTFILE=${LESSHISTFILE:-/tmp/less-hist}
PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

# wget
WGETRC="${XDG_CONFIG_HOME}/wgetrc"
SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

export XDG_CONFIG_HOME XDG_CONFIG_DIR XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR \
    XDG_TEMPLATES_DIR XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR XDG_PICTURES_DIR XDG_VIDEOS_DIR WGETRC SCREENRC

# --- SAFETY WRAPPERS ---

# Safe rm (backup in case safe-rm isn't installed or for specific flags)
rm() {
    # Block root
    if [[ "$@" == "/" ]] || [[ "$@" == "/*" ]]; then
        echo "ERROR: rm root is blocked."
        return 1
    fi
    
    # Warning for Home
    if [[ "$@" == *"$HOME"* ]] || [[ "$@" == *""~""* ]]; then
        read -p "WARNING: You are trying to delete your home directory. Confirm? (y/N) " confirm
        if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
            echo "Cancelled."
            return 1
        fi
    fi

    # Delay for wildcard (rm *)
    if [[ "$@" == *"*"* ]]; then
        echo "Waiting 3 seconds before deleting with wildcard..."
        sleep 3
    fi

    command rm "$@"
}

# Safe dd - Requires confirmation
dd() {
    echo "WARNING: You are about to run 'dd' which can wipe drives."
    echo "Target: $@"
    read -p "Are you sure? (y/N) " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        command dd "$@"
    else
        echo "Cancelled."
    fi
}

# Safe chmod/chown - Warning recursive
chmod() {
    if [[ "$@" == *"-R"* ]]; then
        echo "WARNING: Recursive chmod detected."
    fi
    command chmod "$@"
}

chown() {
    if [[ "$@" == *"-R"* ]]; then
        echo "WARNING: Recursive chown detected."
    fi
    command chown "$@"
}
# Functions

# shell wrapper ability to change the current working directory when exiting Yazi.
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(bat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function no_such_file_or_directory_handler {
    local red='\e[1;31m' reset='\e[0m'
    printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
    return 127
}

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# bun completions
[ -s "/home/diel/.bun/_bun" ] && source "/home/diel/.bun/_bun"

# BAT OPTIONS
eval "$(batman --export-env)"
#→ Use Bat (by itself) for man pages:
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="OneHalfDark"
#→ Use Bat (by itself) for man pages:
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# Automatically launch a tmux session
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#  tmux attach-session -t default || tmux new-session -s default
#fi
  
#Display Pokemon
pokemon-colorscripts --no-title -r 1,3,6
. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/diel/.lmstudio/bin"
# End of LM Studio CLI section

export EDITOR=nvim
export VISUAL=nvim
export set_sysname=$(uname -n)
export PATH="$HOME/eww/target/release:$PATH" # open eww
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH=$PATH:/home/diel/.spicetify

. "$HOME/.local/share/../bin/env"

export PATH="$HOME/.local/bin:$PATH"
alias lzd='lazydocker'

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# pnpm
export PNPM_HOME="/home/diel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
