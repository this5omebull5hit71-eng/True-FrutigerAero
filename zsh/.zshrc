# Configuración inicial - True-Frutiger-Glass (Zsh)
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

# Prompt personalizado simple
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f$ '

# Aliases útiles
alias veo='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias gp='git push -u origin main'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"
