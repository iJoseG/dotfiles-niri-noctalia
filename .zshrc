
# =====================================
# HISTORIAL
# =====================================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# =====================================
# COMPLETION
# =====================================

fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit

# Optimización de carga de compinit (solo regenera caché si tiene más de 24h)
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -d ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

# Ignorar mayúsculas/minúsculas en autocompletado
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'

setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Navegar entre opciones de autocompletado
# Menú de selección visual y colores
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'


#zmodload zsh/zprof

# =====================================
# ALIASES
# =====================================

alias deit="bash <(curl -sL https://raw.githubusercontent.com/iJoseG/Mscripts/refs/heads/main/datetoday.sh)"
alias actrepo="bash <(curl -sL https://raw.githubusercontent.com/iJoseG/Mscripts/refs/heads/main/actrepo.sh)"

alias l='eza -l --icons --color=auto --group-directories-first'
alias ls='eza --icons --color=auto --group-directories-first'
alias ll='eza -l --icons --color=auto --group-directories-first'
alias la='eza -la --icons --color=auto --group-directories-first'
alias lt='eza --tree --icons --color=auto --group-directories-first'

alias proy1='cd ~/Documents/lelninmachin10-04 && source venv_tf/bin/activate && python fine_tuning_app.py'

alias con_davi="/home/jguerra/Documents/Mscripts/conv_davinci.sh"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# =====================================
# PROMPT
# =====================================

eval "$(starship init zsh)"

# =====================================
# PLUGINS
# =====================================

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# History substring
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History search
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# z navigation
source ~/.zsh/z/z.sh

# Configuración avanzada de autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =====================================
# KEYBINDINGS
# =====================================

stty -ixon

# 
bindkey '^Q' kill-whole-line

# Limpiar solo desde cursor hacia el inicio
bindkey '^U' backward-kill-line

# Limpiar desde cursor hasta el final
bindkey '^K' kill-line

# Navegar por palabras
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Borrar palabra completa
bindkey '^H' backward-kill-word

# Ctrl + T -> Busqueda de archivos
# Ctrl + R -> Busqueda en el historial de comandos

# by JoseG

# =====================================
# INTERACTIVE EXECUTION
# =====================================

[[ $- == *i* ]] && fastfetch

# by iJoseG
