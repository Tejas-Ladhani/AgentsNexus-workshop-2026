# Module 11 - Scan an Authorized Remote Server

Set `MCP_URL` to a streamable HTTP or SSE MCP endpoint that you own or have permission to assess.

```powershell
$MCP_URL = "https://mcp.example.com/mcp"
mcp-scanner --analyzers yara,prompt_defense --format detailed remote --server-url $MCP_URL
```

## Public workshop targets

These public MCP servers can be scanned without credentials. Start with `yara` for a deterministic metadata scan, or use `llm` after configuring either LM Studio or Bedrock in [09-llm-analysis.md](09-llm-analysis.md).

### Context7

```powershell
mcp-scanner --analyzers yara --format detailed remote --server-url https://mcp.context7.com/mcp
```

### Microsoft Learn

```powershell
mcp-scanner --analyzers yara --format detailed remote --server-url https://learn.microsoft.com/api/mcp
```

To use semantic analysis with either public target, replace `yara` with `llm`.

For a bearer-protected endpoint, pass the token only from your current shell:

```powershell
$env:MCP_TOKEN = "replace-with-your-token"
mcp-scanner --analyzers yara,prompt_defense --format detailed remote --server-url $MCP_URL --bearer-token $env:MCP_TOKEN
Remove-Item Env:MCP_TOKEN
```

Do not store access tokens in these lab files or commit them to source control.

## Next

For the ready-made local HTTP server, see [06-local-mcp-server.md](06-local-mcp-server.md) and [07-live-remote-scan.md](07-live-remote-scan.md). Continue with [12-mcp-entities.md](12-mcp-entities.md) to scan prompts, resources, and server instructions.