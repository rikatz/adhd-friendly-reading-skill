#!/bin/sh
# AFRS hook helper. POSIX sh only: no other dependencies.
#
# Usage:
#   afrs.sh session claude|codex   Print the AFRS rules (SessionStart hook),
#                                  unless the instruction file already has them.
#   afrs.sh turn claude|codex      Print a one-line reminder (UserPromptSubmit hook).
#   afrs.sh on | off | status      Turn AFRS on or off for every session, or show the state.
#
# Whatever this script prints on stdout is added to the model's context by the
# hook. It prints nothing when AFRS is turned off.

STATE_DIR="${AFRS_HOME:-$HOME/.afrs}"
STATE_FILE="$STATE_DIR/state"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
MARKER="## Reading format (AFRS"

is_off() {
  [ -f "$STATE_FILE" ] && grep -qx "off" "$STATE_FILE"
}

# Find a file that holds the core rules, next to the script or in the repository.
core_source() {
  for f in "$SCRIPT_DIR/../platforms/claude-code/CLAUDE.md" "$SCRIPT_DIR/AGENTS.md" "$SCRIPT_DIR/CLAUDE.md"; do
    if [ -f "$f" ] && grep -q "$MARKER" "$f"; then
      printf '%s\n' "$f"
      return 0
    fi
  done
  return 1
}

# True if the agent's instruction files already contain the AFRS rules,
# so the session hook does not add them a second time.
already_installed() {
  case "$1" in
    codex) files="$HOME/.codex/AGENTS.md $PWD/AGENTS.md" ;;
    *)     files="$HOME/.claude/CLAUDE.md $PWD/CLAUDE.md $PWD/CLAUDE.local.md" ;;
  esac
  for f in $files; do
    [ -f "$f" ] && grep -q "$MARKER" "$f" && return 0
  done
  return 1
}

case "$1" in
  session)
    is_off && exit 0
    already_installed "$2" && exit 0
    src=$(core_source) || exit 0
    # Print the core block: from its heading to the line with the label list.
    sed -n "/^$MARKER/,/Próximos passos)\./p" "$src"
    printf '\n%s\n' "Full rules and document templates: the adhd-friendly-reading skill. In terminal replies, prefer a numbered text walkthrough or an arrow chain (A → B → C) over Mermaid."
    ;;
  turn)
    is_off && exit 0
    printf '%s\n' "AFRS reading format is on: for answers over ~300 words, or with 3+ parts and over ~150 words, or long technical documents, apply the AFRS rules. Keep short answers normal, and honor any feature the user switched off."
    ;;
  on)
    mkdir -p "$STATE_DIR" && printf 'on\n' > "$STATE_FILE"
    printf '%s\n' "AFRS is on for every session (state file: $STATE_FILE)."
    ;;
  off)
    mkdir -p "$STATE_DIR" && printf 'off\n' > "$STATE_FILE"
    printf '%s\n' "AFRS is off for every session (state file: $STATE_FILE). Rules written in CLAUDE.md or AGENTS.md still apply; remove them to turn those off too."
    ;;
  status)
    if is_off; then printf '%s\n' "AFRS is off."; else printf '%s\n' "AFRS is on."; fi
    ;;
  *)
    printf '%s\n' "Usage: afrs.sh session|turn claude|codex, or afrs.sh on|off|status" >&2
    exit 1
    ;;
esac
exit 0
