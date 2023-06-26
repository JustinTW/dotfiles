if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
