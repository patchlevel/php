#!/usr/bin/env bash
set -euo pipefail

# Installer for phpenv.
#
# Works in two ways:
#   1. Run from a local checkout:  ./install.sh
#   2. Piped from the web:         curl -fsSL <raw-url>/install.sh | bash
#      (clones the repo into ~/.phpenv first)

REPO_URL="${PHPENV_REPO_URL:-https://github.com/patchlevel/php.git}"
DEFAULT_ROOT="${PHPENV_ROOT:-$HOME/.phpenv}"

# Figure out whether we are running from inside a checkout.
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/bin/phpenv" ]; then
  PHPENV_ROOT="$SCRIPT_DIR"
else
  PHPENV_ROOT="$DEFAULT_ROOT"
  if [ -d "$PHPENV_ROOT/.git" ]; then
    echo "Updating existing checkout at $PHPENV_ROOT ..."
    git -C "$PHPENV_ROOT" pull --ff-only
  else
    echo "Cloning $REPO_URL into $PHPENV_ROOT ..."
    git clone "$REPO_URL" "$PHPENV_ROOT"
  fi
fi

exec "$PHPENV_ROOT/bin/phpenv" install
