# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_CUSTOM=${HOME}/dotfiles/configs/apps/.oh-my-zsh/custom

export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"

export ZSH="${HOME}/.oh-my-zsh"
plugins=(aliases autojump autopep8 aws brew command-not-found common-aliases compleat cp dircycle dirpersist docker docker-compose encode64 extract fasd git git-auto-fetch git-extras git-flow git-flow-avh gitignore helm history jump kubectl kubectx macos npm nvm pep8 perms pip pyenv python rsync sudo systemadmin tmux virtualenv vscode z zsh-nvm)
ZSH_THEME="robbyrussell"
source ${ZSH}/oh-my-zsh.sh
zstyle ':omz:update' mode disabled  # disable automatic updates

# User configuration
export EDITOR=vim
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

# p10k
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

# powerlevel10k lagcy
[[ ! -f /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme ]] || source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# powerlevel10k
[[ ! -f /usr/local/Cellar/powerlevel10k/1.19.0/share/powerlevel10k/powerlevel10k.zsh-theme ]] || source /usr/local/Cellar/powerlevel10k/1.19.0/share/powerlevel10k/powerlevel10k.zsh-theme

# gvm
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"

# nvm
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home
