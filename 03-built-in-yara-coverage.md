# 03 - Built-In YARA Coverage

Scan the separate suspicious fixture with the scanner's built-in rules:

```powershell
Set-Location C:\workspace\test
mcp-scanner --analyzers yara --format detailed static --tools .\labs\tools-suspicious.json
```

The fixture contains instruction-override and attempted secret-collection wording. The built-in rules may still return `Safe: Yes` because a YARA non-match means no loaded pattern matched. It is not a human approval of the tool.

This is why security scanning combines multiple analyzers and organization-specific rules.

## Next

Continue with [04-custom-yara-demo.md](04-custom-yara-demo.md) to turn this review policy into a deterministic high-severity finding.