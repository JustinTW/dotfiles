# My Dotfiles

macOS dotfiles and provisioning scripts.

## Layout

```
configs/apps/        dotfiles, symlinked into $HOME by config_apps
configs/dotenv/      template for the .env consumed by scripts/install
requirements/        package lists (brew formulae, casks, App Store, VS Code)
scripts/install      entrypoint; dispatches to a stack
scripts/libs/        shared shell functions (common + per-OS)
scripts/stack/       one installer per stack, per OS
```

## Install

Grant your terminal Full Disk Access first (System Settings → Privacy &
Security), and sign in to the App Store so `mas` can install apps.

```sh
cp configs/dotenv/example.env .env    # then edit GIT_USER_NAME / GIT_USER_EMAIL

./scripts/install base                # or: make base
./scripts/install web                 # or: make web
```

`make help` lists every target. Set `DEBUG=1` to trace each command.

Stacks: `base`, `web`, `moxa`, `debug` (re-applies sudo config and symlinks
only).

## Per-machine variables

`configs/apps/.oh-my-zsh/custom/variables.zsh` is gitignored and holds anything
machine-specific:

```sh
cp configs/apps/.oh-my-zsh/custom/variables.zsh.example \
   configs/apps/.oh-my-zsh/custom/variables.zsh
```

Keep real tokens out of tracked files. The template shows how to pull them from
the macOS keychain instead:

```sh
export SOME_TOKEN="$(security find-generic-password -w -s some-token)"
```

## ECR credential helper

The `web` stack wires the Amazon ECR Docker Credential Helper into
`~/.docker/config.json`, so `docker pull` against ECR authenticates itself
instead of relying on a 12-hour token from `aws ecr get-login-password`.

Registries already present in the config are migrated automatically; list any
extra ones in `ECR_REGISTRIES` in `.env`. `credHelpers` does not support
wildcards ([docker/cli#2928](https://github.com/docker/cli/issues/2928)), so
each registry is named explicitly. `credsStore` is deliberately avoided — it
would route every registry, Docker Hub included, through `ecr-login`.

## Backup & restore macOS preferences

```sh
./scripts/osx-backup-pref backup                     # -> ~/Desktop/MacOS_Settings_Backup/<timestamp>
./scripts/osx-backup-pref restore <backup-dir>       # whole snapshot
./scripts/osx-backup-pref restore <domain>.plist     # one domain
```

Backups use `defaults export`, which writes a real property list. `defaults
read` writes a legacy ASCII dump that `defaults import` cannot parse — do not
substitute it.

## Backup home & data volumes

```sh
./scripts/backup
```

Refuses to run unless the backup volume is actually mounted. Override
`BACKUP_VOLUME`, `BACKUP_ROOT` or `DATA_VOLUME` to point elsewhere.

## Upgrade

```sh
brew update && brew upgrade
```

## Lint

```sh
make lint      # shellcheck over every script (also runs in CI)
```
