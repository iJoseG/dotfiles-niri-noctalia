#!/bin/bash

set -u

ZSH_PLUGINS_DIR="${HOME}/.zsh"

if ! command -v git >/dev/null 2>&1; then
    echo "❌ Error: 'git' no está instalado."
    exit 1
fi

mkdir -p "$ZSH_PLUGINS_DIR"

# Lista de plugins base (nombre|repositorio)
PLUGINS=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting"
    "zsh-history-substring-search|https://github.com/zsh-users/zsh-history-substring-search"
    "zsh-completions|https://github.com/zsh-users/zsh-completions"
    "z|https://github.com/rupa/z.git"
)

echo "🔌 Verificando y actualizando plugins de Zsh en $ZSH_PLUGINS_DIR..."
echo " "

installed=0
updated=0
skipped=0
failed=0

declare -A processed

for entry in "${PLUGINS[@]}"; do
    plugin_name="${entry%%|*}"
    repo_url="${entry#*|}"
    dest="${ZSH_PLUGINS_DIR}/${plugin_name}"
    processed["$plugin_name"]=1

    if [ -d "${dest}/.git" ]; then
        echo "↻ Actualizando $plugin_name..."
        if git -C "$dest" pull --ff-only; then
            updated=$((updated + 1))
        else
            echo "❌ Error al actualizar $plugin_name."
            failed=$((failed + 1))
        fi
    elif [ -d "$dest" ]; then
        echo "⚠ $plugin_name ya existe y no es un repositorio git, omitiendo."
        skipped=$((skipped + 1))
    else
        echo "⬇ Instalando $plugin_name..."
        if git clone --depth=1 "$repo_url" "$dest"; then
            installed=$((installed + 1))
        else
            echo "❌ Error al instalar $plugin_name."
            failed=$((failed + 1))
        fi
    fi
    echo " "
done

# Actualizar también cualquier otro plugin git adicional en ~/.zsh/
shopt -s nullglob
for plugin_dir in "$ZSH_PLUGINS_DIR"/*/; do
    plugin_name=$(basename "$plugin_dir")
    if [ -n "${processed[$plugin_name]:-}" ]; then
        continue
    fi

    if [ -d "${plugin_dir}.git" ]; then
        echo "↻ Actualizando $plugin_name (adicional)..."
        if git -C "$plugin_dir" pull --ff-only; then
            updated=$((updated + 1))
        else
            echo "❌ Error al actualizar $plugin_name."
            failed=$((failed + 1))
        fi
        echo " "
    fi
done
shopt -u nullglob

echo "= o = o = o = o = o = o = o = o = o = o = o ="
echo "⬇ Instalados: $installed | ✔ Actualizados: $updated | ⚠ Omitidos: $skipped | ❌ Errores: $failed"

if [ "$failed" -gt 0 ]; then
    exit 1
fi
