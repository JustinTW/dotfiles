# My Dotfiles

## Usage

```
cp configs/dotenv/example.env .env
# enable file permission for term or iterm before install
# login apple store
./scripts/install base
./scripts/install web

ln -sf ~/dotfiles/configs/apps/.oh-my-zsh/custom/example-variables/variables-justinmbp.zsh ~/dotfiles/configs/apps/.oh-my-zsh/custom/variables.zsh
```

install https://lemon.qq.com/


## Upgrade

```
brew upgrade pulumi pnpm homebrew/cask/visual-studio-code
```


## Backup & Restore MacOS Pref

```
defaults read > configs/apps/osx/settings.plist
defaults import configs/apps/osx/settings.plist
```
