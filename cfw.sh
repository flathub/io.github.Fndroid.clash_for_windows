#!/bin/bash
set -e
migrate_checker.sh
export TMPDIR=$XDG_RUNTIME_DIR/app/$FLATPAK_ID
exec zypak-wrapper /app/extra/clash_for_windows/cfw "$@"
