# Dotfiles & Development Environment Setup

Complete backup and restore system for my Debian development environment.

## 🎯 Quick Start (New System)

```bash
# 1. Clone this repository
git clone <your-repo-url> ~/dotfiles

# 2. Run the master setup script
cd ~/dotfiles
chmod +x *.sh
./setup-new-system.sh
```

That's it! The script will:
- Install all modern CLI tools (fzf, eza, zoxide, bat, delta, etc.)
- Restore all configuration files
- Install Quicklisp
- Optionally build SBCL and Emacs from source

## 📦 What's Included

### Configuration Files
- `.bashrc` - Enhanced bash configuration with modern tools
- `.sbclrc` - SBCL configuration with Quicklisp
- `.gitconfig` - Git configuration with delta integration
- `.profile` - Shell profile

### Directories
- `config/common-lisp/` - Common Lisp ASDF configuration
- `radiance/` - Radiance web framework data
- `scripts/` - Build scripts for SBCL and Emacs

### Tools Installed
- **bat** - Better `cat` with syntax highlighting
- **fd** - Better `find` command
- **fzf** - Fuzzy finder for files and history
- **eza** - Better `ls` with icons and git integration
- **zoxide** - Smart `cd` that learns your habits
- **starship** - Beautiful cross-shell prompt
- **git-delta** - Better git diff viewer
- **rlwrap** - Readline wrapper for REPL

## 📝 Individual Scripts

### `backup.sh`
Backs up all configuration files and directories to this repository.

```bash
./backup.sh
```

### `restore.sh`
Restores configuration files from this repository.

```bash
./restore.sh
```

### `install-tools.sh`
Installs all modern CLI tools.

```bash
./install-tools.sh
```

### `install-quicklisp.sh`
Installs Quicklisp for Common Lisp package management.

```bash
./install-quicklisp.sh
```

### `setup-new-system.sh`
Master script that runs everything in the correct order.

```bash
./setup-new-system.sh
```

## 🔄 Workflow

### On Your Current System (Backup)
```bash
cd ~/dotfiles
./backup.sh
git add .
git commit -m "Backup $(date +%Y-%m-%d)"
git push
```

### On a New System (Restore)
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./setup-new-system.sh
```

## 🛠️ Manual Steps (if needed)

### Build SBCL from Source
```bash
~/build-sbcl.sh
```

### Build Emacs from Source
```bash
~/build-emacs.sh
```

### Install Quicklisp
```bash
./install-quicklisp.sh
```

## 📋 System Requirements

- Debian 12+ or Ubuntu 22.04+
- Internet connection for downloading tools
- ~2GB free space for tools and build dependencies
- Additional space if building SBCL/Emacs from source

## 🎨 Features

### Enhanced Bash Experience
- **History**: 50,000 commands saved
- **FZF Integration**: Fuzzy search for files, history, and git
- **Smart Aliases**: Modern replacements for classic commands
- **Beautiful Prompt**: Starship prompt with git integration

### Development Tools
- **SBCL**: Steel Bank Common Lisp with rlwrap
- **Quicklisp**: Common Lisp package manager
- **Emacs**: Built from source with latest features
- **Git**: Enhanced with delta for better diffs

### Quality of Life
- Automatic directory jumping with zoxide
- Syntax-highlighted file viewing with bat
- Fast file searching with fd
- Beautiful directory listings with eza

## 🔧 Customization

Edit the scripts to match your preferences:
- Modify `.bashrc` for different aliases or tools
- Update `install-tools.sh` to add/remove tools
- Adjust `backup.sh` to include additional directories

## 📚 Documentation

- [Starship Prompt](https://starship.rs/)
- [FZF](https://github.com/junegunn/fzf)
- [Eza](https://github.com/eza-community/eza)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Bat](https://github.com/sharkdp/bat)
- [Delta](https://github.com/dandavison/delta)
- [Quicklisp](https://www.quicklisp.org/)

## 🆘 Troubleshooting

### Tools not found after install
```bash
source ~/.bashrc
```

### Quicklisp not loading in SBCL
Check that `~/.sbclrc` exists and contains the Quicklisp setup code.

### Permission denied on scripts
```bash
chmod +x ~/dotfiles/*.sh
```

## 📝 Notes

- All scripts are idempotent - safe to run multiple times
- Backups are incremental - only changed files are updated
- Git credentials are NOT backed up (security)
- SSH keys are NOT backed up (security)

## 🎉 Credits

Created for my personal development workflow. Feel free to fork and adapt!
