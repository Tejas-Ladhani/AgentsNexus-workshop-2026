# Module 10 - Scan MCP Configurations

Review the result before using it against configurations you do not own. This command can start configured local MCP servers or connect to their remote endpoints.

## Supported User-Level Locations

The automatic discovery command checks the scanner's supported user-level paths, such as `%USERPROFILE%\.vscode\mcp.json`, Claude Desktop, Cursor, and Windsurf. It does not automatically inspect a workspace file at `.vscode\mcp.json`.

```powershell
mcp-scanner --scan-known-configs --analyzers yara --format summary
```

If it reports `Config file not found`, that means the corresponding user-level file is absent. It is not an error when your configuration exists only inside this repository.

## Scan This Workspace Config

This repository's VS Code configuration is at `.vscode\mcp.json`. Scan it explicitly from the repository root:

```powershell
mcp-scanner --config-path .\.vscode\mcp.json --analyzers yara --format detailed
```

The `yara` analyzer is local and needs no Cisco or LLM API key. Review the discovered server entries before scanning them; configured entries may connect to public endpoints or start local processes.

## Next

This is an advanced discovery exercise. Continue with [11-remote-server.md](11-remote-server.md) only when you have an authorized remote endpoint.