#!/bin/bash
set -e
gtk-launch migrate_checker.sh || 0
export TMPDIR=$XDG_RUNTIME_DIR/app/$FLATPAK_ID
exec zypak-wrapper /app/extra/clash_for_windows/cfw "$@" || 0
pkill clash-linux
