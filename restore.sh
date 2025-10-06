#!/bin/bash
# Restore script - restores all configuration files and sets up environment

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "🔄 Restoring configuration from $DOTFILES_DIR..."

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: $DOTFILES_DIR not found!"
    echo "Please clone your dotfiles repository first:"
    echo "  git clone <your-repo-url> ~/dotfiles"
    exit 1
fi

# Restore home dotfiles
echo "📁 Restoring home dotfiles..."
if [ -f "$DOTFILES_DIR/home/.bashrc" ]; then
    cp -v "$DOTFILES_DIR/home/.bashrc" ~/.bashrc
fi

if [ -f "$DOTFILES_DIR/home/.sbclrc" ]; then
    cp -v "$DOTFILES_DIR/home/.sbclrc" ~/.sbclrc
fi

if [ -f "$DOTFILES_DIR/home/.gitconfig" ]; then
    cp -v "$DOTFILES_DIR/home/.gitconfig" ~/.gitconfig
fi

if [ -f "$DOTFILES_DIR/home/.profile" ]; then
    cp -v "$DOTFILES_DIR/home/.profile" ~/.profile
fi

# Restore Emacs configuration
echo "📁 Restoring Emacs configuration..."
if [ -d "$DOTFILES_DIR/emacs.d" ]; then
    mkdir -p ~/.emacs.d
    cp -v "$DOTFILES_DIR/emacs.d/init.el" ~/.emacs.d/ 2>/dev/null || true
    cp -v "$DOTFILES_DIR/emacs.d/early-init.el" ~/.emacs.d/ 2>/dev/null || true
    cp -v "$DOTFILES_DIR/emacs.d/config.org" ~/.emacs.d/ 2>/dev/null || true
    cp -v "$DOTFILES_DIR/emacs.d/custom.el" ~/.emacs.d/ 2>/dev/null || true
    
    # Restore directories
    if [ -d "$DOTFILES_DIR/emacs.d/snippets" ]; then
        cp -rv "$DOTFILES_DIR/emacs.d/snippets" ~/.emacs.d/ 2>/dev/null || true
    fi
    if [ -d "$DOTFILES_DIR/emacs.d/themes" ]; then
        cp -rv "$DOTFILES_DIR/emacs.d/themes" ~/.emacs.d/ 2>/dev/null || true
    fi
fi

# Restore .config directories
echo "📁 Restoring .config directories..."
mkdir -p ~/.config

if [ -d "$DOTFILES_DIR/config/common-lisp" ]; then
    cp -rv "$DOTFILES_DIR/config/common-lisp" ~/.config/
fi

if [ -d "$DOTFILES_DIR/config/starship" ]; then
    cp -rv "$DOTFILES_DIR/config/starship" ~/.config/
fi

# Restore radiance directory
echo "📁 Restoring radiance directory..."
if [ -d "$DOTFILES_DIR/radiance" ]; then
    cp -rv "$DOTFILES_DIR/radiance" ~/
fi

# Restore build scripts
echo "📁 Restoring build scripts..."
if [ -f "$DOTFILES_DIR/scripts/build-sbcl.sh" ]; then
    cp -v "$DOTFILES_DIR/scripts/build-sbcl.sh" ~/
    chmod +x ~/build-sbcl.sh
fi

if [ -f "$DOTFILES_DIR/scripts/build-emacs.sh" ]; then
    cp -v "$DOTFILES_DIR/scripts/build-emacs.sh" ~/
    chmod +x ~/build-emacs.sh
fi

echo "✅ Configuration files restored!"
echo ""
echo "💡 Next steps:"
echo "   1. Run: source ~/.bashrc"
echo "   2. Install Quicklisp: ./install-quicklisp.sh"
echo "   3. Build SBCL: ./build-sbcl.sh (if needed)"
echo "   4. Build Emacs: ./build-emacs.sh (if needed)"
echo "   5. Install modern tools: ./install-tools.sh"
