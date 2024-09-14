# Enable emacs mode for command line editing
# set -o emacs

# Add bin and local/bin to path
[ -d "/usr/local/bin" ] && PATH="/usr/local/bin:${PATH}"
[ -d "${HOME}/bin" ] && PATH="${HOME}/bin:${PATH}"

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() {
  rg --files "$1" | with-dir "$1"
}

# Use rg to generate the list for directory completion
_fzf_compgen_dir() {
  rg --files "$1" | only-dir "$1"
}

export FZF_DEFAULT_OPTS='
  --color=dark
'

# syntax highlighting
# Technically, this is not needed in Warp, but it's included for persistence
# across blocks.
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# completion (not needed in Warp)
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Yarn (commented out if not needed)
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# asdf version manager
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
export NODEJS_CHECK_SIGNATURES=no

# Docker
export COMPOSE_HTTP_TIMEOUT=300

# keychain (conditional for Linux)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  /usr/bin/keychain --nogui $HOME/.ssh/id_rsa
  source $HOME/.keychain/$HOSTNAME-sh
fi

# aws-vault
export AWS_VAULT_PROMPT=ykman

# console1987
export CONSOLE_USER=emilio

# Disable fork safety
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Load aliases if file exists
[[ -f ~/.aliases ]] && source ~/.aliases

# Load local .zshrc configurations if file exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Datadog
export DD_TRACE_STARTUP_LOGS=false

# OpenAI vim plugin key
export OPENAI_API_KEY=$OPENAI_KEY

# Prioritize local node_modules bin for npm scripts
export PATH=node_modules/.bin:$PATH

# Postgres 16 path addition
export PATH=$PATH:$HOMEBREW_PREFIX/opt/postgresql@16/bin

# Initialize Starship prompt
eval "$(starship init zsh)"
