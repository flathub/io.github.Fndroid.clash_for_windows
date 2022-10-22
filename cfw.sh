#!/bin/bash
set -e
xterm /app/bin/migrate_checker.sh || true
export TMPDIR=$XDG_RUNTIME_DIR/app/$FLATPAK_ID
zypak-wrapper /app/extra/clash_for_windows/cfw "$@" || true
pkill clash-linux
