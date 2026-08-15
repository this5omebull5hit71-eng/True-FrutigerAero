# Configuración inicial - True-Frutiger-Glass (Zsh)
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

# Prompt personalizado simple
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f$ '

# Aliases útiles
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
