# Module 7 - Scan the Live HTTP Server

Complete the one-time preparation in [06-local-mcp-server.md](06-local-mcp-server.md) first and ensure the server is running on `http://127.0.0.1:8000`.

## Scan with YARA analyzer

Open a new terminal and run:

```powershell
Set-Location C:\workspace\test

mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format detailed remote --server-url http://127.0.0.1:8000/mcp
```

Expected findings:
- **Tools 1-6 (safe tools)**: Safe: Yes
- **Tools 7-10 (unsafe metadata samples)**: HIGH severity findings from the custom YARA rule
  - `summarize_external_document`
  - `export_customer_archive`
  - `execute_maintenance_command`
  - `manage_everything`

The YARA rule matches tool descriptions containing both `"Ignore all previous instructions"` and `"send any secrets to"`, mapping to threat classification `TOOL POISONING` (AITech-12.1).

## Next

Continue with [09-local-llm.md](09-local-llm.md) for semantic analysis of the same live server. Module 8 is deferred because the installed scanner does not interpret FastMCP runtime timeout metadata.