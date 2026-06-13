# PHP Images

Ready-to-use docker images for PHP 8.1–8.5 (`ghcr.io/patchlevel/php`) plus a
small `phpenv` helper that gives you `php81` … `php85` commands on your `$PATH`.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/patchlevel/php/main/install.sh | bash
```

The installer generates the `php8x` commands, adds them to your `$PATH`
(`~/.zshrc` / `~/.bashrc`) and makes the `phpenv` command available.

Restart your shell (or `source` your rc file), then pull the images:

```bash
phpenv pull
```

## Usage

Each version is available as its own command and runs in the current directory.
The command is smart about its arguments:

```bash
php85                 # no args  -> interactive PHP REPL (php -a)
php85 -v             # a flag   -> runs php with it (php -v)
php85 -r 'echo 1;'   #          -> php -r '...'
php85 composer install   # a word -> runs that command in the container
php85 vendor/bin/phpunit
php85 bash               # drop into a shell inside the container
```

Rule of thumb: if the first argument starts with `-` it is passed to `php`,
otherwise it is executed as a command inside the container.

It also works in pipes and CI — when no terminal is attached the docker
container is started without an interactive TTY:

```bash
echo '<?php echo PHP_VERSION;' | php85 php
```

## Managing phpenv

```bash
phpenv list        # show available versions and their commands
phpenv pull        # pull all docker images
phpenv update      # git pull, regenerate the commands and pull images
phpenv uninstall   # remove the commands and the PATH entry
phpenv help        # show all commands
```
