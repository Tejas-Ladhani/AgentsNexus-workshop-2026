# AgentsNexus 2026 Lab Guide

This guide contains the full hands-on sequence for **Hacking and Hardening AI Agents: Hands-On Security Scanning for the Tool Ecosystem**. It uses Cisco AI Defense MCP Scanner as a CLI. Run commands only against lab fixtures, local servers you control, or remote systems you are authorized to assess.

## Learning path

1. [01-cli-baseline.md](01-cli-baseline.md) - confirm the CLI and identify its scan modes
2. [02-offline-static-scan.md](02-offline-static-scan.md) - inspect an MCP `tools/list` snapshot without a server
3. [03-built-in-yara-coverage.md](03-built-in-yara-coverage.md) - see the coverage limit of built-in YARA rules
4. [04-custom-yara-demo.md](04-custom-yara-demo.md) - make a deterministic security finding with a local policy rule
5. [05-output-and-triage.md](05-output-and-triage.md) - interpret severity, taxonomy, filters, and JSON reports
6. [06-local-mcp-server.md](06-local-mcp-server.md) - start the ready-made customer-operations HTTP MCP server with FastMCP
7. [07-live-remote-scan.md](07-live-remote-scan.md) - scan the HTTP server through remote endpoint
8. [08-live-readiness.md](08-live-readiness.md) - deferred: scanner readiness heuristics are incompatible with standard FastMCP metadata
9. [09-llm-analysis.md](09-llm-analysis.md) - semantic analysis through LM Studio or Amazon Bedrock
10. [10-known-configs.md](10-known-configs.md) - discover configured MCP clients, with authorization safeguards
11. [11-remote-server.md](11-remote-server.md) - scan an authorized remote HTTP or SSE MCP endpoint
12. [12-mcp-entities.md](12-mcp-entities.md) - optional: scan live prompts, resources, and server instructions
13. [13-behavioral-analysis.md](13-behavioral-analysis.md) - compare source implementation with declared tool intent

Advanced follow-up: use `behavioral` for source-level behavior versus declared intent, and `vulnerable-package`, `npm-scan`, or `pypi-scan` for supply-chain review. See [analyzers-reference.md](analyzers-reference.md) and [owasp-scenarios.md](owasp-scenarios.md). An A2A lab would be a separate future track; this MCP Scanner version has no A2A or agent-skill scan mode.

## Analyzer choices

| Analyzer | Purpose | Needs a key? |
| --- | --- | --- |
| `yara` | Deterministic pattern matching against tool metadata | No |
| `readiness` | Reliability heuristics such as timeouts, retries, and tool scope | No |
| `prompt_defense` | Defensive guidance checks for prompts and descriptions | No |
| `llm` | Semantic review for threats such as tool poisoning | Yes, LLM provider |
| `api` | Cisco AI Defense inspection | Yes, Cisco AI Defense |
| `behavioral` | Source code behavior versus documented intent | Yes, LLM provider |

Start the workshop with the offline labs. Do not treat a `Safe: Yes` result as proof that a tool is safe; it means the selected analyzers did not produce a finding.