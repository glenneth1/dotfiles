#!/bin/bash
# Install Common Lisp dependencies for Asteroid Radio project

set -e

echo "📦 Installing Common Lisp dependencies for Asteroid Radio..."
echo "=============================================================="
echo ""

# Check if SBCL is installed
if ! command -v sbcl >/dev/null 2>&1; then
    echo "❌ Error: SBCL is not installed!"
    echo "Please install SBCL first:"
    echo "  sudo apt install sbcl"
    echo "  OR run: ./build-sbcl.sh"
    exit 1
fi

# Check if Quicklisp is installed
if [ ! -d ~/quicklisp ]; then
    echo "❌ Error: Quicklisp is not installed!"
    echo "Please install Quicklisp first:"
    echo "  ./install-quicklisp.sh"
    exit 1
fi

echo "✅ SBCL found: $(sbcl --version 2>&1 | head -1)"
echo "✅ Quicklisp found"
echo ""

# Install all dependencies via Quicklisp
echo "📥 Installing Asteroid Radio dependencies..."
echo ""

sbcl --non-interactive --eval '
(ql:quickload :slynk)
(ql:quickload :radiance)
(ql:quickload :i-log4cl)
(ql:quickload :r-clip)
(ql:quickload :r-simple-rate)
(ql:quickload :r-simple-profile)
(ql:quickload :lass)
(ql:quickload :cl-json)
(ql:quickload :alexandria)
(ql:quickload :local-time)
(ql:quickload :taglib)
(ql:quickload :r-data-model)
(ql:quickload :ironclad)
(ql:quickload :babel)
(ql:quickload :cl-fad)
(ql:quickload :bordeaux-threads)
(ql:quickload :drakma)
(format t "~%~%✅ All dependencies installed successfully!~%")
'

echo ""
echo "=============================================================="
echo "✅ Installation complete!"
echo ""
echo "📋 Installed packages:"
echo "   • Radiance - Web framework"
echo "   • LASS - CSS preprocessor"
echo "   • Slynk - REPL server"
echo "   • CL-JSON - JSON parser"
echo "   • Taglib - Audio metadata"
echo "   • And many more..."
echo ""
echo "💡 You can now build and run Asteroid Radio!"
echo "   cd ~/Projects/Code/asteroid"
echo "   make"
echo "   ./asteroid"
