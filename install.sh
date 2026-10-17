#!/usr/bin/env bash
# Copy the AgentKit dev skills into a skills folder.
# Usage: ./install.sh [--claude | --agents] [--global] [skill-name ...]
#   --claude   install to .claude/skills   (Claude Code)           [default]
#   --agents   install to .agents/skills   (Codex, Cursor, Gemini CLI, GitHub Copilot and others)
#   --global   install under your home directory instead of the current project
# With no skill names, every skill in this folder is installed. Existing skills are not overwritten.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target=".claude/skills"; scope="project"; names=()
for arg in "$@"; do
  case "$arg" in
    --claude) target=".claude/skills" ;;
    --agents) target=".agents/skills" ;;
    --global) scope="global" ;;
    -h|--help) sed -n '2,8p' "$0"; exit 0 ;;
    -*) echo "Unknown option: $arg" >&2; exit 2 ;;
    *) names+=("$arg") ;;
  esac
done

if [ "$scope" = "global" ]; then
  case "$target" in
    .claude/skills) dest="$HOME/.claude/skills" ;;
    *) dest="$HOME/.config/agents/skills"
       echo "Note: global folders for .agents-style tools differ by tool (for example ~/.codex/skills, ~/.cursor/skills, ~/.gemini/skills). Installing to $dest; copy or symlink it where your tool looks." ;;
  esac
else
  dest="$PWD/$target"
fi

if [ ${#names[@]} -eq 0 ]; then
  for d in "$here"/skills/*/; do names+=("$(basename "$d")"); done
fi

mkdir -p "$dest"
for n in "${names[@]}"; do
  src="$here/skills/$n"
  if [ ! -f "$src/SKILL.md" ]; then echo "No such skill: $n" >&2; exit 1; fi
  if [ -e "$dest/$n" ]; then echo "skip   $n (already exists in $dest)"; continue; fi
  cp -R "$src" "$dest/$n"
  echo "added  $n -> $dest/$n"
done
echo "Done. Start a new session (or run /reload-skills in Claude Code) so the skills are picked up."
