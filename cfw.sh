#!/bin/bash
set -e
gtk-launch io.github.Fndroid.clash_for_windows-migrate_checker || true
export TMPDIR=$XDG_RUNTIME_DIR/app/$FLATPAK_ID
zypak-wrapper /app/extra/clash_for_windows/cfw "$@" || true
pkill clash-linux
