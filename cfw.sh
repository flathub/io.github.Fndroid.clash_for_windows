#!/bin/bash
set -e
gtk-launch /app/extra/migrate_checker.desktop || true
export TMPDIR=$XDG_RUNTIME_DIR/app/$FLATPAK_ID
zypak-wrapper /app/extra/clash_for_windows/cfw "$@" || true
pkill clash-linux
