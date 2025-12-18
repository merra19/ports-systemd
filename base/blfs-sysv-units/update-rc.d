#!/bin/bash

# update-rc.d <script> defaults [priority] | remove
# Simplified version for SysVinit systems

INIT_DIR="/etc/init.d"
RC_DIR="/etc"
DEFAULT_PRIORITY=20

usage() {
  echo "Usage:"
  echo "  $0 <script_name> defaults [priority]"
  echo "  $0 <script_name> remove"
  exit 1
}

parse_runlevels() {
  local script="$1"
  START_RUNLEVELS=()
  STOP_RUNLEVELS=()

  while IFS= read -r line; do
    case "$line" in
      *Default-Start:*)
        START_RUNLEVELS=($(echo "$line" | sed -n 's/.*Default-Start:[[:space:]]*\(.*\)/\1/p'))
        ;;
      *Default-Stop:*)
        STOP_RUNLEVELS=($(echo "$line" | sed -n 's/.*Default-Stop:[[:space:]]*\(.*\)/\1/p'))
        ;;
    esac
  done < "$INIT_DIR/$script"

  # Fallback if no metadata found
  if [ ${#START_RUNLEVELS[@]} -eq 0 ]; then
    START_RUNLEVELS=(2 3 4 5)
  fi
  if [ ${#STOP_RUNLEVELS[@]} -eq 0 ]; then
    STOP_RUNLEVELS=(0 1 6)
  fi
}

create_links() {
  for rl in "${START_RUNLEVELS[@]}"; do
    ln -sf "$INIT_DIR/$SCRIPT" "$RC_DIR/rc${rl}.d/S${PRIORITY}$SCRIPT"
    echo "Created start link: rc${rl}.d/S${PRIORITY}$SCRIPT"
  done
  for rl in "${STOP_RUNLEVELS[@]}"; do
    ln -sf "$INIT_DIR/$SCRIPT" "$RC_DIR/rc${rl}.d/K${PRIORITY}$SCRIPT"
    echo "Created stop link: rc${rl}.d/K${PRIORITY}$SCRIPT"
  done
}

remove_links() {
  for d in "$RC_DIR"/rc[0-6].d/; do
    rm -f "$d/S"*"$SCRIPT" "$d/K"*"$SCRIPT"
  done
  echo "Removed all rc.d links for $SCRIPT"
}

# Main
SCRIPT="$1"
ACTION="$2"
PRIORITY="${3:-$DEFAULT_PRIORITY}"

[ -z "$SCRIPT" ] || [ -z "$ACTION" ] && usage
[ ! -f "$INIT_DIR/$SCRIPT" ] && echo "Error: $SCRIPT not found in $INIT_DIR" && exit 1

case "$ACTION" in
  defaults)
    parse_runlevels "$SCRIPT"
    create_links
    ;;
  remove)
    remove_links
    ;;
  *)
    usage
    ;;
esac
