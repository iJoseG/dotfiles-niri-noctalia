# =====================================
# PATH & ENTORNO
# =====================================
# Binarios locales del usuario
export PATH="$HOME/.local/bin:$PATH"

# Cargar colores del sistema para autocompletado y ls
if (( $+commands[dircolors] )); then
  eval "$(dircolors -b)"
fi

# =====================================
# HISTORIAL
# =====================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY          # Guarda fecha, hora y duración de cada comando
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY             # Comparte historial entre terminales en tiempo real
setopt HIST_EXPIRE_DUPS_FIRST    # Borra duplicados primero cuando se llena el historial
setopt HIST_IGNORE_ALL_DUPS      # No guarda comandos repetidos consecutivamente
setopt HIST_IGNORE_SPACE         # No guarda comandos que inicien con espacio (útil para secretos)
setopt HIST_FIND_NO_DUPS         # No muestra duplicados al buscar en el historial
setopt HIST_REDUCE_BLANKS        # Elimina espacios en blanco redundantes
setopt HIST_VERIFY               # Permite editar antes de ejecutar si se llama desde historial

# =====================================
# NAVEGACIÓN Y GLOBBING
# =====================================
setopt AUTO_CD                   # Escribe el nombre de un directorio o .. para entrar sin cd
setopt AUTO_PUSHD                # Guarda historial de carpetas visitadas (navega con cd -<tab>)
setopt PUSHD_IGNORE_DUPS         # No duplica directorios en el historial de pushd
setopt PUSHD_SILENT              # Silencia el listado de carpetas al usar pushd/popd
setopt EXTENDED_GLOB             # Habilita patrones avanzados (requerido para compinit optimization)

# =====================================
# COMPLETION
# =====================================
fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit

# Optimización de carga: regenera caché solo si tiene más de 24h, sino usa -C (instantáneo)
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -d ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

# Ignorar mayúsculas/minúsculas en autocompletado
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" "r:|[._-]=* r:|=*"

setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Menú de selección visual y colores
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu select
zstyle ":completion:*:*:cd:*:directory-stack" menu yes select
zstyle ":completion:*" group-name ""
zstyle ":completion:*:descriptions" format "%F{yellow}-- %d --%f"

# =====================================
# INTEGRACIÓN FZF + FD
# =====================================
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"
fi

# =====================================
# PLUGINS & HERRAMIENTAS
# =====================================
# 1. zoxide (reemplazo inteligente y rápido en Rust para z.sh)
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
elif [[ -f ~/.zsh/z/z.sh ]]; then
  source ~/.zsh/z/z.sh
fi

# 2. fzf (atajos de teclado y completion)
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# 3. Autosuggestions (configuración ANTES de cargar el script)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# 4. Syntax Highlighting (debe cargarse ANTES de history-substring-search)
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 5. History Substring Search (debe cargarse DESPUÉS de syntax-highlighting)
if [[ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
fi

# =====================================
# PROMPT
# =====================================
eval "$(starship init zsh)"

# =====================================
# KEYBINDINGS
# =====================================
bindkey -e
stty -ixon

bindkey "^Q" kill-whole-line
bindkey "^U" backward-kill-line
bindkey "^K" kill-line

# Navegación por palabras (Ctrl + Flechas)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Borrar palabra hacia atrás
bindkey "^H" backward-kill-word
bindkey "^W" backward-kill-word

# Teclas estándar (Home, End, Supr)
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# =====================================
# ALIASES
# =====================================
# Navegación rápida
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# eza (ls moderno con iconos y orden por directorios)
alias ls="eza --icons --color=auto --group-directories-first"
alias l="eza -l --icons --color=auto --group-directories-first"
alias ll="eza -la --icons --git --color=auto --group-directories-first"
alias la="eza -la --icons --color=auto --group-directories-first"
alias lt="eza --tree --icons --color=auto --group-directories-first"

# Proyectos y utilidades
alias deit="bash <(curl -sL https://raw.githubusercontent.com/iJoseG/Mscripts/refs/heads/main/utils/actrepo.sh)"
alias actrepo="bash <(curl -sL https://raw.githubusercontent.com/iJoseG/Mscripts/refs/heads/main/utils/actrepo.sh)"
alias proy1="cd ~/Documents/lelninmachin10-04 && source venv_tf/bin/activate && python fine_tuning_app.py"
alias con_davi="/home/jguerra/Documents/Mscripts/conv_davinci.sh"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# =====================================
# INTERACTIVE EXECUTION
# =====================================
# Solo ejecutar fastfetch en terminal interactiva con TTY real
[[ -o interactive && -t 1 ]] && fastfetch
