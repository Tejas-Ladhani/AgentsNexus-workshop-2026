# Module 10 - Scan Known Configurations

Review the result before using it against configurations you do not own. This command can start configured local MCP servers or connect to their remote endpoints.

```powershell
Set-Location C:\workspace\test
mcp-scanner --scan-known-configs --analyzers yara --format summary
```

The `yara` analyzer is local and needs no Cisco or LLM API key. The command searches the supported client configuration locations, including VS Code, Claude, Cursor, and Windsurf.

## Next

This is an advanced discovery exercise. Continue with [11-remote-server.md](11-remote-server.md) only when you have an authorized remote endpoint.