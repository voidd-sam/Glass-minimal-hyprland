# auto start hyprland 
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec start-hyprland
fi

fastfetch

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History
HISTSIZE=10000
HISTFILESIZE=20000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Autosuggestion accept with right arrow
bindkey '→' autosuggest-accept


# Created by `pipx` on 2026-07-29 11:09:00
export PATH="$PATH:/home/sam/.local/bin"

# set fzf to fd
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"



# Prevent concurrent write corruption
setopt APPEND_HISTORY          # Append instead of overwrite
setopt INC_APPEND_HISTORY      # Write immediately, don't wait
setopt HIST_SAVE_NO_DUPS       # Don't save duplicates
setopt HIST_IGNORE_DUPS        # Ignore duplicate commands
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space
setopt HIST_REDUCE_BLANKS      # Remove blank lines from history
setopt HIST_NO_FUNCTIONS       # Don't save functions

# Limit history to prevent file bloat
HISTSIZE=50000
SAVEHIST=10000
HISTFILE=~/.zsh_history

