#!/bin/bash

set -e

echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o = o = o = o = o "
echo " "
echo " "
echo "      INSTALANDO ZSH + Starship-prompt by jguerra"
echo " "
echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o = o = o = o = o"

sleep 1
echo " "
# Instalar paquetes base
sudo pacman -S --needed --noconfirm git zsh nano curl eza fastfetch fzf

# Instalacion de JetBrainsMono Nerd Font
echo "Instalando JetBrainsMono Nerd Font..."
sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd
fc-cache -fv

echo "✔ JetBrainsMono Nerd Font está listo."

echo " "

echo " "
echo "Instalando Starship..."
curl -sS https://starship.rs/install.sh -o install.sh
sh install.sh -y
rm install.sh
echo " "

echo " "
echo "Instalando herramientas de zsh..."
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo " "
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
echo " "
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
echo " "
git clone https://github.com/zsh-users/zsh-completions ~/.zsh/zsh-completions
echo " "
git clone https://github.com/rupa/z.git ~/.zsh/z
echo " "

echo " "

echo "Estableciendo preset de starship: catppuccin-powerline..."
mkdir -p ~/.config
starship preset jetpack -o ~/.config/starship.toml

chsh -s /bin/zsh

echo " "
echo " "
echo "Reinicia la sesión o ejecuta: exec zsh"
echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o ="
echo " "
echo " "
echo "      Instalacion Finalizada ...by jguerra           "
echo " "
echo " "
echo "= o = o = o = o = o = o = o = o = o = o = o = o ="

