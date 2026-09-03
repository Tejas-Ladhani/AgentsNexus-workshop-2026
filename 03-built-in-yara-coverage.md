# 03 - Built-In YARA Coverage

Scan the separate suspicious fixture with the scanner's built-in rules:

```powershell
mcp-scanner --analyzers yara --format detailed static --tools .\labs\tools-suspicious.json
```

## Expected Output

The fixture contains instruction-override, secret-collection, arbitrary-command, and unrestricted-access wording. In the verified run:

- `export_customer_archive` is flagged as `DATA EXFILTRATION` with HIGH severity.
- `summarize_external_document`, `execute_maintenance_command`, and `manage_everything` return `Safe: Yes`.

Your exact output can vary slightly with the installed scanner version and built-in rule set.

## What This Demonstrates

This partial result is expected. A YARA non-match means no loaded pattern matched that item; it is not a human approval of the tool. In static mode, the displayed `https://mcp.deepwiki.com/mcp` target is only the CLI's default report label; the scanner reads the local fixture and does not connect to that URL.

This is why security scanning combines multiple analyzers and organization-specific rules.

## Next

Continue with [04-custom-yara-demo.md](04-custom-yara-demo.md) to turn this review policy into a deterministic high-severity finding.