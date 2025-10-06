#!/bin/bash
# Backup script - saves all important config files and directories

set -e

BACKUP_DIR="$HOME/dotfiles"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🔄 Backing up configuration files to $BACKUP_DIR..."

# Create backup directory structure
mkdir -p "$BACKUP_DIR/config"
mkdir -p "$BACKUP_DIR/home"
mkdir -p "$BACKUP_DIR/scripts"

# Backup dotfiles from home directory
echo "📁 Backing up home dotfiles..."
cp -v ~/.bashrc "$BACKUP_DIR/home/.bashrc"
cp -v ~/.sbclrc "$BACKUP_DIR/home/.sbclrc"
cp -v ~/.gitconfig "$BACKUP_DIR/home/.gitconfig"
cp -v ~/.profile "$BACKUP_DIR/home/.profile" 2>/dev/null || true

# Backup .config directories
echo "📁 Backing up .config directories..."
if [ -d ~/.config/common-lisp ]; then
    cp -rv ~/.config/common-lisp "$BACKUP_DIR/config/"
fi

if [ -d ~/.config/starship ]; then
    cp -rv ~/.config/starship "$BACKUP_DIR/config/" 2>/dev/null || true
fi

# Backup radiance directory
echo "📁 Backing up radiance directory..."
if [ -d ~/radiance ]; then
    cp -rv ~/radiance "$BACKUP_DIR/"
fi

# Backup quicklisp (just the setup, not all libraries)
echo "📁 Backing up quicklisp setup..."
if [ -d ~/quicklisp ]; then
    mkdir -p "$BACKUP_DIR/quicklisp"
    cp -v ~/quicklisp/setup.lisp "$BACKUP_DIR/quicklisp/" 2>/dev/null || true
fi

# Backup build scripts
echo "📁 Backing up build scripts..."
if [ -f ~/build-sbcl.sh ]; then
    cp -v ~/build-sbcl.sh "$BACKUP_DIR/scripts/"
fi

if [ -f ~/build-emacs.sh ]; then
    cp -v ~/build-emacs.sh "$BACKUP_DIR/scripts/"
fi

# Create a list of installed packages
echo "📦 Saving list of installed packages..."
if command -v apt >/dev/null 2>&1; then
    dpkg --get-selections > "$BACKUP_DIR/installed-packages.txt"
fi

# Create a list of manually installed tools
echo "🔧 Documenting installed tools..."
cat > "$BACKUP_DIR/installed-tools.txt" << EOF
# Installed Tools and Versions
Generated: $(date)

$(command -v sbcl >/dev/null && echo "SBCL: $(sbcl --version 2>&1 | head -1)" || echo "SBCL: not installed")
$(command -v emacs >/dev/null && echo "Emacs: $(emacs --version | head -1)" || echo "Emacs: not installed")
$(command -v starship >/dev/null && echo "Starship: $(starship --version)" || echo "Starship: not installed")
$(command -v fzf >/dev/null && echo "FZF: $(fzf --version)" || echo "FZF: not installed")
$(command -v eza >/dev/null && echo "Eza: $(eza --version | head -1)" || echo "Eza: not installed")
$(command -v zoxide >/dev/null && echo "Zoxide: $(zoxide --version)" || echo "Zoxide: not installed")
$(command -v batcat >/dev/null && echo "Bat: $(batcat --version)" || echo "Bat: not installed")
$(command -v delta >/dev/null && echo "Delta: $(delta --version)" || echo "Delta: not installed")
$(command -v fdfind >/dev/null && echo "Fd: $(fdfind --version)" || echo "Fd: not installed")
$(command -v rlwrap >/dev/null && echo "Rlwrap: installed" || echo "Rlwrap: not installed")
EOF

echo "✅ Backup complete!"
echo "📍 Files saved to: $BACKUP_DIR"
echo ""
echo "💡 Next steps:"
echo "   1. cd ~/dotfiles"
echo "   2. git init (if not already a repo)"
echo "   3. git add ."
echo "   4. git commit -m 'Backup $(date +%Y-%m-%d)'"
echo "   5. git push to your remote repository"
