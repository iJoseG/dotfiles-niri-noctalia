# Mis Dotfiles (Niri + Arch Linux)

Configuraciones personales para Wayland y Arch Linux gestionadas con un *Git Bare Repository*.

---

## 🛠️ Componentes Principales

| Categoría | Herramienta / Configuración |
| :--- | :--- |
| **Compositor (Wayland)** | [Niri](https://github.com/YaLTeR/niri) / Hyprland |
| **Barra & Temas** | [Noctalia](https://github.com/Noctalia-dev) + [Matugen](https://github.com/InioX/matugen) |
| **Terminales** | [Alacritty](https://alacritty.org/) / [Ghostty](https://ghostty.org/) |
| **Shell & Prompt** | [Zsh](https://www.zsh.org/) + [Starship](https://starship.rs/) (preset jetpack optimizado) |
| **Editor de Código** | [Neovim](https://neovim.io/) |
| **Bloqueo / Idle** | Hyprlock + Hypridle |
| **Utilidades de Terminal** | Fastfetch, Eza, Fzf, Z |

---

## 🚀 Instalación en un Nuevo Sistema

### 1. Clonar el repositorio Bare de Dotfiles
```bash
git clone --bare https://github.com/iJoseG/dotfiles-niri-noctalia $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f
```

### 2. Configurar Zsh + Starship automáticamente
El repositorio incluye un script optimizado e idempotente para instalar paquetes base, complementos de Zsh y configurar el prompt:

```bash
# Ejecutar el script localmente tras clonar
bash ~/scripts-dotfiles/inst_zsh_star_opti.sh
```

> **Nota:** También puedes ejecutar el instalador de la terminal de forma rápida en cualquier sistema Arch Linux mediante:
> ```bash
> bash <(curl -sL https://raw.githubusercontent.com/iJoseG/dotfiles-niri-noctalia/refs/heads/main/scripts-dotfiles/inst_zsh_star_opti.sh)
> ```

---

## 🔌 Complementos y Plugins de Zsh incluidos
El script de instalación y `.zshrc` configuran automáticamente:
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Sugerencias automáticas estilo Fish.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Resaltado de sintaxis en tiempo real.
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - Búsqueda rápida en el historial con flechas arriba/abajo.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - Definiciones adicionales de autocompletado.
- [z](https://github.com/rupa/z) - Navegación inteligente a directorios frecuentes.
- [fzf](https://github.com/junegunn/fzf) - Búsqueda interactiva (`Ctrl+R` historial, `Ctrl+T` archivos).

---

## ⚙️ Gestión de Dotfiles
Para gestionar las configuraciones mediante el alias `dotfiles`:

```bash
dotfiles status                             # Ver estado de archivos modificados
dotfiles add <archivo>                      # Agregar cambios al stage
dotfiles commit -m "feat: nuevos cambios"   # Crear un commit
dotfiles push                               # Subir al repositorio
```
