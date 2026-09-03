# MCP Security Scenario Map

The ready-made server is a functional customer-operations scan target with four intentionally unsafe-looking tool descriptions. Those four implementations are inert: they return status data only and do not perform the described action.

| Tool or fixture | Teaching case | Closest OWASP 2025 risk | Scanner path |
| --- | --- | --- | --- |
| `lookup_order` and `search_orders` | Focused data-access tools | Least privilege contrast | YARA and LLM baseline |
| `export_customer_summary` | Redacted support export | LLM02 Sensitive Information Disclosure | LLM and manual data-boundary review |
| `request_account_action` | Human approval before account changes | LLM06 Excessive Agency | LLM and manual design review |
| `summarize_external_document` | Instruction override and context harvesting | LLM01 Prompt Injection | Custom YARA and LLM |
| `export_customer_archive` | Hidden credential collection claim | LLM02 Sensitive Information Disclosure | Custom YARA and LLM |
| `execute_maintenance_command` | Overt credential theft claim | LLM02 Sensitive Information Disclosure | Custom YARA and LLM |
| `manage_everything` | Instruction override and unrestricted access claim | LLM01 / LLM06 | Custom YARA and LLM |
| `tools-suspicious.json` | Custom-rule exercise | LLM01 and LLM02 | Custom YARA and local LLM |

## MCP entities in this server

| Entity | Server item | Scanner command family |
| --- | --- | --- |
| Tool | Customer operations tools | `remote` on HTTP endpoint |
| Prompt | `support_reply` | `remote` on HTTP endpoint |
| Resource | `customer://orders/{order_id}` | `remote` on HTTP endpoint |
| Server instructions | Customer Operations instructions | `remote` on HTTP endpoint |

| `demo-tool-poisoning.yara` | Organization policy for hostile descriptions | LLM01 / Tool poisoning | YARA |

The server also supports source and dependency scans without another MCP server: use `behavioral` on `labs/customer-operations-server` after LLM setup, and `vulnerable-package` on the same directory.

## What this server does not claim to cover

Supply chain, data or model poisoning, output handling, system prompt leakage, vector or embedding weaknesses, and misinformation need dedicated package, source, runtime, and architecture exercises. MCP Scanner is an assessment tool, not an automatic OWASP Top 10 compliance test.

## Workshop scan

After preparation in [06-local-mcp-server.md](06-local-mcp-server.md) and starting the server, scan all remote tool definitions with deterministic checks:

```powershell
Set-Location C:\workspace\test
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format detailed remote --server-url http://127.0.0.1:8000/mcp
```

Start with `yara`. Later, add `llm` after configuring LM Studio or Amazon Bedrock. Compare semantic findings with deterministic YARA evidence rather than treating either as a complete verdict.