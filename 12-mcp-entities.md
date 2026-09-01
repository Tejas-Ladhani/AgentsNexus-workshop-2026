# Module 12 - Optional: Scan Prompts, Resources, and Instructions

Tools are not the only MCP metadata surface. This optional module scans the live FastMCP server's prompt, resource template, and server instructions after completing [06-local-mcp-server.md](06-local-mcp-server.md).

## Prompts

```powershell
Set-Location C:\workspace\test

mcp-scanner --analyzers yara --format detailed prompts --server-url http://127.0.0.1:8000/mcp
```

To scan just the workshop prompt:

```powershell
mcp-scanner --analyzers yara --format detailed prompts --server-url http://127.0.0.1:8000/mcp --prompt-name support_reply
```

## Resources

```powershell
mcp-scanner --analyzers yara --format detailed resources --server-url http://127.0.0.1:8000/mcp
```

To scan just the order resource template:

```powershell
mcp-scanner --analyzers yara --format detailed resources --server-url http://127.0.0.1:8000/mcp --resource-uri "customer://orders/{order_id}"
```

## Server Instructions

```powershell
mcp-scanner --analyzers yara --format detailed instructions --server-url http://127.0.0.1:8000/mcp
```

The workshop prompt, resource, and instructions are deliberately benign. A `Safe: Yes` result means that the selected analyzer found no matching metadata pattern; it does not prove the server implementation is safe.

## Other Analyzer Paths

- `prompt_defense`: checks whether tools and instructions contain defensive prompt-safety guidance.
- `behavioral`: compares source behavior with declared intent. Requires LLM configuration and source access.
- `vulnerable-package`, `npm-scan`, and `pypi-scan`: review dependency supply-chain risk.
- `virustotal`: checks known file hashes and requires a VirusTotal API key.
- `api`: sends metadata to Cisco AI Defense and requires an AI Defense API key.
- `--enable-meta`: applies an LLM second pass to correlate findings from other analyzers.

See [analyzers-reference.md](analyzers-reference.md) for requirements and limitations.
