#!/bin/bash
# Complete setup script for a fresh Debian installation
# This is the master script that runs everything in the correct order

set -e

echo "🎯 Setting up new Debian development environment..."
echo "=================================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Make all scripts executable
chmod +x "$SCRIPT_DIR"/*.sh

# Step 1: Install basic tools
echo "Step 1/5: Installing modern CLI tools..."
"$SCRIPT_DIR/install-tools.sh"
echo ""

# Step 2: Restore configuration files
echo "Step 2/5: Restoring configuration files..."
"$SCRIPT_DIR/restore.sh"
echo ""

# Step 3: Install Quicklisp (if SBCL is available)
if command -v sbcl >/dev/null 2>&1; then
    echo "Step 3/5: Installing Quicklisp..."
    if [ ! -d ~/quicklisp ]; then
        "$SCRIPT_DIR/install-quicklisp.sh"
    else
        echo "⏭️  Quicklisp already installed, skipping..."
    fi
else
    echo "Step 3/5: Skipping Quicklisp (SBCL not found)"
    echo "   Run ./build-sbcl.sh or install SBCL, then run ./install-quicklisp.sh"
fi
echo ""

# Step 4: Build SBCL (if script exists and SBCL not installed)
if [ -f ~/build-sbcl.sh ] && ! command -v sbcl >/dev/null 2>&1; then
    echo "Step 4/5: Building SBCL from source..."
    read -p "Build SBCL now? This may take 10-20 minutes. (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ~/build-sbcl.sh
    else
        echo "⏭️  Skipping SBCL build. Run ~/build-sbcl.sh manually later."
    fi
else
    echo "Step 4/5: SBCL already installed or build script not found"
fi
echo ""

# Step 5: Build Emacs (if script exists and Emacs not installed)
if [ -f ~/build-emacs.sh ] && ! command -v emacs >/dev/null 2>&1; then
    echo "Step 5/5: Building Emacs from source..."
    read -p "Build Emacs now? This may take 20-30 minutes. (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ~/build-emacs.sh
    else
        echo "⏭️  Skipping Emacs build. Run ~/build-emacs.sh manually later."
    fi
else
    echo "Step 5/5: Emacs already installed or build script not found"
fi
echo ""

# Reload bash configuration
echo "🔄 Reloading bash configuration..."
source ~/.bashrc

echo ""
echo "=================================================="
echo "✅ Setup complete!"
echo ""
echo "📋 Summary:"
echo "   ✓ Modern CLI tools installed"
echo "   ✓ Configuration files restored"
echo "   ✓ Quicklisp configured (if SBCL available)"
echo ""
echo "💡 Next steps:"
echo "   1. Restart your terminal or run: source ~/.bashrc"
echo "   2. Test your setup: sbcl, emacs, fzf, etc."
echo "   3. Clone your projects from Git"
echo ""
echo "🎉 Happy coding!"
