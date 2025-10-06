#!/bin/bash
# Build Emacs from source with PGTK support
# Based on GNU Emacs build instructions

set -e

echo "🚀 Building Emacs from source..."
echo "================================"
echo ""

# Install build dependencies
echo "📦 Installing build dependencies..."
sudo apt update
sudo apt install -y \
    build-essential \
    libgtk-3-dev \
    libgnutls28-dev \
    libtiff5-dev \
    libgif-dev \
    libjpeg-dev \
    libpng-dev \
    libxpm-dev \
    libncurses-dev \
    texinfo \
    git

# Native JSON support
echo "📦 Installing native JSON support..."
sudo apt install -y libjansson4 libjansson-dev

# Native compilation support
echo "📦 Installing native compilation support..."
sudo apt install -y libgccjit0 libgccjit-10-dev gcc-10 g++-10

# Cairo and SVG support
echo "📦 Installing Cairo and SVG support..."
sudo apt install -y libcairo2-dev librsvg2-dev

# Set compiler to GCC 10 for native compilation
echo "🔧 Setting compiler to GCC 10..."
export CC=/usr/bin/gcc-10
export CXX=/usr/bin/gcc-10

echo ""
echo "📥 Cloning Emacs repository..."
cd ~
if [ -d ~/emacs ]; then
    echo "⚠️  Emacs directory already exists. Updating..."
    cd ~/emacs
    git pull
else
    git clone git://git.sv.gnu.org/emacs.git
    cd ~/emacs
fi

echo ""
echo "🔧 Running autogen.sh..."
./autogen.sh

echo ""
echo "⚙️  Configuring with native compilation, JSON, PGTK, Cairo, modules, and SVG support..."
./configure --with-native-compilation --with-json --with-pgtk --with-cairo --with-modules --with-rsvg

echo ""
echo "🔨 Building Emacs (this may take 15-30 minutes)..."
make -j$(nproc)

echo ""
echo "📦 Installing Emacs..."
sudo make install

echo ""
echo "✅ Emacs build complete!"
echo ""
echo "🎉 You can now run: emacs"
echo ""
echo "💡 Version installed:"
emacs --version | head -1
