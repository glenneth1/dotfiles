#!/bin/bash
# Install Quicklisp for Common Lisp package management

set -e

echo "📦 Installing Quicklisp..."

# Check if SBCL is installed
if ! command -v sbcl >/dev/null 2>&1; then
    echo "❌ Error: SBCL is not installed!"
    echo "Please install SBCL first:"
    echo "  sudo apt install sbcl"
    echo "  OR run: ./build-sbcl.sh"
    exit 1
fi

# Download Quicklisp
echo "⬇️  Downloading Quicklisp..."
cd ~
wget https://beta.quicklisp.org/quicklisp.lisp

# Install Quicklisp
echo "🔧 Installing Quicklisp..."
sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(ql:add-to-init-file)' --quit

# Clean up
rm quicklisp.lisp

echo "✅ Quicklisp installed successfully!"
echo ""
echo "💡 Quicklisp is now configured in ~/.sbclrc"
echo "   You can now use (ql:quickload :package-name) in SBCL"
