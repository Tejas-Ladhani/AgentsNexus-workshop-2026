#!/usr/bin/env bash
# AgentsNexus 2026 - one-command attendee setup (macOS / Linux).
# Installs uv (if missing), pins Python 3.13, the mcp-scanner CLI, and the
# local FastMCP workshop server's dependencies.
# Run from the repository root:
#   chmod +x setup.sh && ./setup.sh

set -euo pipefail

echo "== AgentsNexus 2026 workshop setup =="

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# mcp-scanner is only validated on Python 3.13. macOS/Linux ship prebuilt
# yara-python wheels for 3.13, so no compiler toolchain is normally required.
echo "Installing Python 3.13 (pinned; mcp-scanner does not support 3.14+)..."
uv python install 3.13

echo "Installing mcp-scanner CLI (cisco-ai-mcp-scanner)..."
uv tool install cisco-ai-mcp-scanner --python 3.13

echo "Installing the local FastMCP workshop server dependencies..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$SCRIPT_DIR/labs/customer-operations-server" >/dev/null
uv sync --python 3.13
popd >/dev/null

echo "Verifying mcp-scanner..."
mcp-scanner --help | head -n 3

cat <<'NOTE'

If mcp-scanner fails to build yara-python from source (rare, only when no
prebuilt wheel matches your platform), install the Xcode Command Line Tools
first:
    xcode-select --install
then rerun ./setup.sh.

Setup complete. Start with 00-workshop-roadmap.md.
NOTE
