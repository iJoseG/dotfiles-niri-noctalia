# Mis Dotfiles (Niri + Arch Linux)

Configuraciones personales para Wayland y Arch Linux gestionadas con un *Git Bare Repository*.

## 🛠️ Componentes
- **Compositor:** Niri
- **Barra/Estilos:** Noctalia
- **Terminal:** Alacritty
- **Shell:** Zsh
- **Idle Daemon:** Hypridle
- **Fetch:** Fastfetch

## 🚀 Instalación en un nuevo sistema
```bash
git clone --bare https://github.com/iJoseG/dotfiles-niri-noctalia $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
