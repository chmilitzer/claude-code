#!/usr/bin/env bash
# Installiert die PE-Lifecycle-Agenten und den /dd-debate-Command als persoenliche
# Claude-Code-Ressourcen (~/.claude). Repo bleibt die Quelle der Wahrheit.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_AGENTS="${HOME}/.claude/agents"
DEST_COMMANDS="${HOME}/.claude/commands"

mkdir -p "$DEST_AGENTS" "$DEST_COMMANDS"

cp -v "$SRC_DIR"/agents/*.md "$DEST_AGENTS"/
cp -v "$SRC_DIR"/commands/*.md "$DEST_COMMANDS"/

echo ""
echo "Fertig. Installiert:"
echo "  Agenten  -> $DEST_AGENTS (pe-bull, pe-bear, pe-referee, pe-legal-*, pe-tax-*, pe-anonymizer, pe-report-extractor, pe-reconciler)"
echo "  Command  -> $DEST_COMMANDS/dd-debate.md  (Aufruf: /dd-debate <deal-id>)"
echo ""
echo "Hinweis: In dieser Remote-Umgebung ist ~/.claude ephemer. Nach Container-Neustart"
echo "erneut ausfuehren: bash pe-lifecycle/install.sh"
