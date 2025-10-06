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
# Try to find available GCC version
if apt-cache search libgccjit-13-dev | grep -q libgccjit-13-dev; then
    echo "Found GCC 13, installing..."
    sudo apt install -y libgccjit0 libgccjit-13-dev gcc-13 g++-13
    export CC=/usr/bin/gcc-13
    export CXX=/usr/bin/g++-13
elif apt-cache search libgccjit-12-dev | grep -q libgccjit-12-dev; then
    echo "Found GCC 12, installing..."
    sudo apt install -y libgccjit0 libgccjit-12-dev gcc-12 g++-12
    export CC=/usr/bin/gcc-12
    export CXX=/usr/bin/g++-12
elif apt-cache search libgccjit-11-dev | grep -q libgccjit-11-dev; then
    echo "Found GCC 11, installing..."
    sudo apt install -y libgccjit0 libgccjit-11-dev gcc-11 g++-11
    export CC=/usr/bin/gcc-11
    export CXX=/usr/bin/g++-11
else
    echo "Installing default GCC and libgccjit..."
    sudo apt install -y libgccjit0 libgccjit-dev gcc g++
    export CC=/usr/bin/gcc
    export CXX=/usr/bin/g++
fi

# Cairo and SVG support
echo "📦 Installing Cairo and SVG support..."
sudo apt install -y libcairo2-dev librsvg2-dev

# Show which compiler we're using
echo "🔧 Using compiler: $CC"
gcc --version | head -1

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
