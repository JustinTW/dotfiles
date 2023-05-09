eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

# p10k paths
possible_p10k_paths=(
  $(brew --prefix)/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
  /usr/local/Cellar/powerlevel10k/1.19.0/share/powerlevel10k/powerlevel10k.zsh-theme
  $(brew --prefix)/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme
)
# foreach possible_p10k_paths if exist, source it
for p10k_path in "${possible_p10k_paths[@]}"; do
  [[ ! -f "${p10k_path}" ]] || source "${p10k_path}"
done

ZSH_CUSTOM=${HOME}/dotfiles/configs/apps/.oh-my-zsh/custom

export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"

export ZSH="${HOME}/.oh-my-zsh"
plugins=(aliases autojump autopep8 aws brew command-not-found common-aliases compleat cp dircycle dirpersist docker docker-compose encode64 extract fasd git git-auto-fetch git-extras git-flow git-flow-avh gitignore helm history jump kubectl kubectx macos npm nvm pep8 perms pip pyenv python rsync sudo systemadmin tmux virtualenv vscode z)
ZSH_THEME="robbyrussell"
source ${ZSH}/oh-my-zsh.sh
zstyle ':omz:update' mode disabled  # disable automatic updates

# User configuration
export EDITOR=vim
export LANG=en_US.UTF-8

# Automatically detect system architecture using uname
export ARCHFLAGS="-arch $(uname -m)"

# gvm - only load in interactive shells
if [[ -s "${HOME}/.gvm/scripts/gvm" ]] && [[ -o interactive ]]; then
  source "${HOME}/.gvm/scripts/gvm" 2>/dev/null || true
fi

# Avoid console output after instant prompt preamble
if [[ -z "${POWERLEVEL9K_INSTANT_PROMPT}" ]]; then
  # nvm instal v18 requirements
  brew install python-setuptools
fi

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home

HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
  source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi
