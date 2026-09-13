#!/bin/bash

set -e

# Prevenir ejecución directa como root o con sudo
if [ "$EUID" -eq 0 ]; then
    echo "❌ No ejecutes este script directamente con sudo o como root."
    echo "El script solicitará permisos de sudo cuando sea necesario para pacman."
    exit 1
fi

echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o = o = o = o = o "
echo " "
echo " "
echo "      INSTALANDO ZSH + Starship-prompt (Optimizada) by jguerra"
echo " "
echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o = o = o = o = o "
echo " "

sleep 1

# 1. Instalar paquetes base (incluyendo starship y fuentes desde repositorios oficiales)
echo "📦 Instalando paquetes base..."
sudo pacman -S --needed --noconfirm git zsh nano curl eza fastfetch fzf starship ttf-jetbrains-mono-nerd

echo "🔄 Actualizando caché de fuentes..."
fc-cache -fv >/dev/null 2>&1
echo "✔ JetBrainsMono Nerd Font está lista."
echo " "

# 2. Función auxiliar para clonar o actualizar plugins con shallow clone (--depth 1)
clone_or_update() {
    local repo="$1"
    local dest="$2"
    if [ -d "$dest/.git" ]; then
        echo "↻ Actualizando $(basename "$dest")..."
        git -C "$dest" pull --ff-only || true
    elif [ -d "$dest" ]; then
        echo "⚠ $dest ya existe y no es un repositorio git, omitiendo."
    else
        echo "⬇ Clonando $(basename "$dest")..."
        git clone --depth=1 "$repo" "$dest"
    fi
}

# 3. Instalación de herramientas y plugins de zsh
echo "🔌 Instalando complementos de Zsh..."
mkdir -p ~/.zsh
clone_or_update https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
clone_or_update https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
clone_or_update https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions
clone_or_update https://github.com/rupa/z.git ~/.zsh/z
echo " "

# 4. Configurar Starship
echo "🚀 Configurando Starship..."
mkdir -p ~/.config
if [ -f ~/.config/starship.toml ]; then
    cp ~/.config/starship.toml ~/.config/starship.toml.bak
    echo "ℹ Se creó un respaldo en ~/.config/starship.toml.bak"
fi

if curl -fsSL https://raw.githubusercontent.com/iJoseG/dotfiles-niri-noctalia/refs/heads/main/.config/starship.toml -o ~/.config/starship.toml 2>/dev/null; then
    echo "✔ Configuración de Starship descargada desde el repositorio dotfiles-niri-noctalia."
else
    echo "⚠ No se pudo descargar starship.toml del repositorio, aplicando preset jetpack..."
    starship preset jetpack -o ~/.config/starship.toml
fi
echo " "

# 5. Descargar y configurar ~/.zshrc desde el repositorio
echo "📝 Configurando ~/.zshrc..."
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.bak
    echo "ℹ Se creó un respaldo de tu .zshrc en ~/.zshrc.bak"
fi

curl -fsSL https://raw.githubusercontent.com/iJoseG/dotfiles-niri-noctalia/refs/heads/main/.zshrc -o ~/.zshrc
echo "✔ ~/.zshrc descargado y configurado exitosamente."
echo " "

# 6. Cambiar shell por defecto si no es Zsh
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
    echo "🐚 Cambiando shell por defecto a Zsh..."
    chsh -s "$(command -v zsh)"
else
    echo "✔ Zsh ya es tu shell por defecto."
fi

echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o ="
echo " "
echo " "
echo "      Instalación Finalizada ...by jguerra       "
echo " "
echo " "
echo "Reinicia la sesión o ejecuta: exec zsh"
echo "= o = o = o = o = o = o = o = o = o = o = o = o ="
