# Module 5 - Output and Triage

Run the same authorized scan with formats suited to different audiences.

> Static-mode note: the `server_url` field or `Scan Target` display may contain the CLI default `https://mcp.deepwiki.com/mcp`. Treat the local file arguments as the real scan input; `static` does not connect to that URL.

## Summary Output

Use this concise view for a presentation or CI log:

```powershell
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format summary static --tools .\labs\tools-suspicious.json
```

## Detailed Output

Use this investigation view for complete per-analyzer evidence and taxonomy mappings:

```powershell
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format detailed static --tools .\labs\tools-suspicious.json
```

## Raw JSON Output

Use this machine-readable envelope for audit records and automation:

```powershell
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format raw --output .\labs\scan-results.json static --tools .\labs\tools-suspicious.json
```

Read findings in this order:

1. `Safe` indicates whether any selected analyzer found an issue.
2. `Severity` is the highest severity from that analyzer.
3. `Threat Names` identifies the threat class.
4. `MCP Taxonomies` supplies the `AITech` and `AISubtech` mappings for reporting and remediation tracking.

For a CI gate, evaluate the `scan_results` in the raw JSON output and fail only on the severity threshold your team has agreed to. Do not fail merely because a tool name sounds powerful; use the finding evidence and an explicit policy.

## Next

Continue with [06-local-mcp-server.md](06-local-mcp-server.md) to prepare the ready-made live scan target.