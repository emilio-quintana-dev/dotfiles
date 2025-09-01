# Dotfiles

Personal configuration files for zsh, neovim, git, and development tools.

## Prerequisites

- **macOS**
- **Command line tools**: `xcode-select --install`

## Setup

1. **Clone this repository**
   ```bash
   git clone https://github.com/emilio-quintana-dev/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install Homebrew** (if not already installed)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Install all dependencies**
   ```bash
   brew bundle --file=Brewfile
   ```

4. **Set up dotfiles**
   ```bash
   env RCRC=$HOME/dotfiles/rcrc rcup
   ```

## Post-Install Setup

After running the installation:

1. **Restart your shell** or run `source ~/.zshrc`

2. **Set up asdf versions** (install your preferred language versions)
   ```bash
   # Example: Install Node.js
   asdf plugin add nodejs
   asdf install nodejs latest
   asdf global nodejs latest
   ```

3. **Configure Git** (update with your details)
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

4. **Install Neovim plugins** (if using Neovim)
   - Open `nvim` and run `:PackerInstall` or similar based on your plugin manager

## What's Included

- **Shell**: zsh configuration with custom functions and aliases
- **Editor**: Neovim configuration 
- **Version Control**: Git configuration with helpful aliases
- **Development Tools**: fzf, ripgrep, fd, bat, and more for enhanced CLI experience
- **Package Management**: asdf for managing language versions

## Updating

You can safely run `rcup` multiple times to update symlinks when you make changes:

```bash
rcup
```

## Troubleshooting

### Common Issues

**`rcup` command not found**
- Make sure rcm is installed: `brew install rcm`

**Homebrew not in PATH**
- After installing Homebrew, add it to your PATH:
  ```bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  ```

**asdf command not found**
- Source your shell config: `source ~/.zshrc`
- Or restart your terminal

**Git configuration issues**
- Your Git config is already set up in the dotfiles, but you'll need to update the user name and email for commits

## Contributing

Pull-requests are welcome, but it would probably make more sense just to fork them and make them your own unless your PR is for a bug fix.

## License

This software is free and distributable under the MIT license.
