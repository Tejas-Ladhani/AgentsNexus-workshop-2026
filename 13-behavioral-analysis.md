# Module 13 - Behavioral Analysis

Behavioral analysis compares an MCP server's source code with the intent declared in its tool descriptions. It requires an LLM provider and reads the local source directory; it does not scan a remote URL or execute the tools.

## Prepare the LLM provider

Configure either LM Studio or Amazon Bedrock using [09-llm-analysis.md](09-llm-analysis.md). The behavioral analyzer uses the same LLM configuration as the semantic remote scan.

## Run the source scan

Run this from the repository root:

```powershell
mcp-scanner behavioral .\labs\customer-operations-server --format detailed
```

## Expected Output

The analyzer should inspect the tool declarations and implementations. Pay special attention to:

- `lookup_delivery_window`: its description promises an order delivery window, but its implementation returns notification-service status.
- The four intentionally unsafe-looking tools: their descriptions claim sensitive or dangerous behavior, while their implementations are inert demonstrations.
- The ordinary customer-operations tools: their descriptions and implementations should be broadly aligned.

The exact finding wording depends on the selected LLM provider and model. Preserve the scanner version, model ID, and source revision with any report.

## What This Demonstrates

Remote metadata scanning asks, "What does the agent receive?" Behavioral analysis asks, "Does the source code do what the metadata says?"

This catches a different class of risk:

- A benign description paired with undeclared secret access or network calls.
- A tool that claims to be harmless but performs unrelated operations.
- A declaration that promises one result while the implementation returns another.

Behavioral analysis is source review, not runtime testing. It cannot verify behavior created only by external dependencies, configuration, or runtime conditions.

## Safety

The workshop server is safe to inspect. All suspicious tool implementations are inert and have no side effects.

## Next

Continue with [12-mcp-entities.md](12-mcp-entities.md) for optional prompt, resource, and instruction scans, or [11-remote-server.md](11-remote-server.md) for authorized public endpoints.
