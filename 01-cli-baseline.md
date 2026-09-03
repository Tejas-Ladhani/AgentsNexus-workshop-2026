# 01 - Verify the CLI

Run this from the lab workspace:

```powershell
mcp-scanner --help
```

Expected result: the banner reads `MCP Security Scanner - Comprehensive security analysis for MCP servers`, followed by the available subcommands.

This check makes no network requests, starts no MCP server, and needs no API keys.

## Next

Continue with [02-offline-static-scan.md](02-offline-static-scan.md). It is fully local and is the first actual scan in this workshop.