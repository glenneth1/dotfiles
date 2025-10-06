#!/bin/bash
# Install all the modern CLI tools used in your bash configuration

set -e

echo "🚀 Installing modern CLI tools..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt update

# Install basic dependencies
echo "📦 Installing basic dependencies..."
sudo apt install -y \
    curl \
    wget \
    git \
    build-essential \
    unzip \
    rlwrap

# Install bat (better cat)
echo "🦇 Installing bat..."
sudo apt install -y bat

# Install fd-find (better find)
echo "🔍 Installing fd..."
sudo apt install -y fd-find

# Install fzf (fuzzy finder)
echo "🔎 Installing fzf..."
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-zsh --no-fish
fi

# Install eza (better ls)
echo "📂 Installing eza..."
if ! command -v eza >/dev/null 2>&1; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

# Install zoxide (better cd)
echo "🚀 Installing zoxide..."
if ! command -v zoxide >/dev/null 2>&1; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Install starship (prompt)
echo "⭐ Installing starship..."
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install git-delta (better git diff)
echo "📊 Installing git-delta..."
if ! command -v delta >/dev/null 2>&1; then
    DELTA_VERSION="0.17.0"
    wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
    rm "git-delta_${DELTA_VERSION}_amd64.deb"
fi

# Clone fzf-git integration
echo "🔧 Installing fzf-git integration..."
if [ ! -d ~/fzf-git.sh ]; then
    git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh
fi

echo "✅ All tools installed successfully!"
echo ""
echo "💡 Installed tools:"
echo "   • bat (batcat) - better cat with syntax highlighting"
echo "   • fd (fdfind) - better find"
echo "   • fzf - fuzzy finder"
echo "   • eza - better ls with icons"
echo "   • zoxide - smart cd"
echo "   • starship - beautiful prompt"
echo "   • git-delta - better git diff"
echo "   • rlwrap - readline wrapper for REPL"
echo ""
echo "🔄 Run: source ~/.bashrc"
