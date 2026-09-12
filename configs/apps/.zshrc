# ---------------------------------------------------------------------------
# Homebrew -- first, because everything below resolves tools through it.
# brew shellenv exports HOMEBREW_PREFIX, so no `brew --prefix` subprocesses
# are needed further down.
# ---------------------------------------------------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"     # Apple Silicon
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"        # Intel
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k theme
if [[ -r "${HOMEBREW_PREFIX}/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${HOMEBREW_PREFIX}/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# ---------------------------------------------------------------------------
# pyenv -- must come before oh-my-zsh.sh. The pyenv plugin checks that
# $(pyenv root)/shims is already in $PATH and warns loudly if it is not.
# ---------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
command -v pyenv &>/dev/null && eval "$(pyenv init --path)"

# ---------------------------------------------------------------------------
# oh-my-zsh
# ---------------------------------------------------------------------------
ZSH_CUSTOM="${HOME}/dotfiles/configs/apps/.oh-my-zsh/custom"
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Dropped: fasd (unmaintained, not installed), compleat (not installed),
# autopep8 / pep8 (deprecated), git-flow (superseded by git-flow-avh).
plugins=(
  aliases autojump aws brew command-not-found common-aliases cp dircycle
  dirpersist docker docker-compose encode64 extract git git-auto-fetch
  git-extras git-flow-avh gitignore helm history jump kubectl kubectx macos
  npm nvm perms pip pyenv python rsync sudo systemadmin tmux virtualenv
  vscode z
)

zstyle ':omz:update' mode disabled  # must be set before oh-my-zsh.sh runs
source "${ZSH}/oh-my-zsh.sh"

# ---------------------------------------------------------------------------
# User configuration
# ---------------------------------------------------------------------------
export EDITOR=vim
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch $(uname -m)"

# ---------------------------------------------------------------------------
# Language runtimes -- each guarded, so a machine missing one still gets a
# working shell instead of an error on every prompt.
# ---------------------------------------------------------------------------

# gvm - only load in interactive shells
if [[ -s "${HOME}/.gvm/scripts/gvm" ]] && [[ -o interactive ]]; then
  source "${HOME}/.gvm/scripts/gvm" 2>/dev/null || true
fi

# Auto-switch Go version based on .go-version file.
# No --default here: that would rewrite the global default on every cd.
autoload -U add-zsh-hook
_auto_gvm_use() {
  [[ -f .go-version ]] || return
  command -v gvm &>/dev/null || return
  local ver current
  ver=$(<.go-version)
  current=$(go version 2>/dev/null | awk '{print $3}')
  [[ "$current" == "$ver" ]] || gvm use "$ver" 2>/dev/null || true
}
add-zsh-hook chpwd _auto_gvm_use
_auto_gvm_use

# Rust / Cargo
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
[[ -d "$PNPM_HOME" && ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$BUN_INSTALL/bin:$PATH"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Solana CLI
[[ -d "$HOME/.local/share/solana/install/active_release/bin" ]] &&
  export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Anchor (avm)
[[ -d "$HOME/.avm/bin" ]] && export PATH="$HOME/.avm/bin:$PATH"

# Java, as shipped inside Android Studio
[[ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]] &&
  export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

# Keep Homebrew ahead of nvm's shims for globally installed CLIs.
export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"

# ---------------------------------------------------------------------------
# Terminal hygiene
# ---------------------------------------------------------------------------

# Reset mouse tracking mode that programs (vim, fzf, etc.) may leave enabled on crash
_reset_mouse_tracking() {
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l' > /dev/tty 2>/dev/null
}
add-zsh-hook precmd _reset_mouse_tracking

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Must stay last: it configures the theme sourced above.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
