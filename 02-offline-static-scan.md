# 02 - Offline Static Scan

This lab scans a saved MCP `tools/list` response. It makes no network request and does not start an MCP server.

> Note: current CLI output can display `https://mcp.deepwiki.com/mcp` as the scan target when `--server-url` was not supplied. In `static` mode this is only a default report label; the scanner reads the files passed through `--tools`, `--prompts`, or `--resources` and does not connect to that URL.

```powershell
mcp-scanner --analyzers yara --format detailed static --tools .\labs\tools.json
```

The fixture is deliberately small and safe. It teaches the expected `tools/list` input shape. The current static CLI path reports the YARA result; use the live-server labs for readiness and prompt-defense checks.

Use `--format raw --output results.json` when a CI job needs machine-readable output.

## Next

Continue with [03-built-in-yara-coverage.md](03-built-in-yara-coverage.md).