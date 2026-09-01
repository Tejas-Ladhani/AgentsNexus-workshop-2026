# MCP Scanner Workshop

These runbooks use the standalone Cisco AI Defense MCP Scanner CLI installed with `uv`. Follow this order.

1. [00-workshop-roadmap.md](00-workshop-roadmap.md) - workshop scope and analyzer overview
2. [01-cli-baseline.md](01-cli-baseline.md) - verify the installed command
3. [02-offline-static-scan.md](02-offline-static-scan.md) - scan the benign `tools/list` fixture
4. [03-built-in-yara-coverage.md](03-built-in-yara-coverage.md) - see the coverage limit of built-in YARA rules
5. [04-custom-yara-demo.md](04-custom-yara-demo.md) - detect hostile metadata with a local rule
6. [05-output-and-triage.md](05-output-and-triage.md) - read detailed, summary, and JSON output
7. [06-local-mcp-server.md](06-local-mcp-server.md) - prepare the included customer-operations MCP server
8. [07-live-remote-scan.md](07-live-remote-scan.md) - scan the HTTP server through remote endpoint
9. [08-live-readiness.md](08-live-readiness.md) - deferred readiness-analyzer compatibility note
10. [09-local-llm.md](09-local-llm.md) - semantic analysis through LM Studio or Amazon Bedrock
11. [10-known-configs.md](10-known-configs.md) - discover configured MCP clients, with authorization safeguards
12. [11-remote-server.md](11-remote-server.md) - scan an authorized remote HTTP or SSE endpoint
13. [12-mcp-entities.md](12-mcp-entities.md) - optional: scan live prompts, resources, and server instructions

Reference material: [analyzers-reference.md](analyzers-reference.md) and [owasp-scenarios.md](owasp-scenarios.md).