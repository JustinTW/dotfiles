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
export ARCHFLAGS="-arch x86_64"

# gvm
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# nvm
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# volta
# export VOLTA_FEATURE_PNPM=1

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

[[ -s "/Users/robo/.gvm/scripts/gvm" ]] && source "/Users/robo/.gvm/scripts/gvm"

[[ -s "/Users/justinct_liu/.gvm/scripts/gvm" ]] && source "/Users/justinct_liu/.gvm/scripts/gvm"
