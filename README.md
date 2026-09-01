# AgentsNexus 2026

## Hacking and Hardening AI Agents

**Hands-On Security Scanning for the Tool Ecosystem**

September 4, 2026 | 10:30 AM - 12:30 PM

Agents connect to an ecosystem of MCP servers, tools, prompts, resources, and external services. This hands-on lab demonstrates how to inspect that metadata, detect hostile tool descriptions, and compare deterministic rules with semantic LLM analysis.

## Start Here

Follow the complete workshop sequence in [00-workshop-roadmap.md](00-workshop-roadmap.md).

The core lab uses:

- Cisco AI Defense MCP Scanner
- A local FastMCP customer-operations server with inert malicious-metadata samples
- Custom YARA rules for deterministic detection
- LM Studio or Amazon Bedrock for semantic analysis

## What You Will Practice

- Scan static MCP tool metadata with YARA.
- Write and apply a custom detection rule.
- Run live HTTP MCP server scans.
- Identify prompt injection, data exfiltration, and tool poisoning metadata.
- Compare deterministic YARA findings with LLM-as-judge results.
- Scan authorized public MCP endpoints.

## Safety

Run commands only against lab fixtures, local servers you control, or systems you are explicitly authorized to assess. The suspicious workshop tools are inert: they return demonstration status data and do not execute commands, access secrets, or make network calls.

## Reference

[Analyzer reference](analyzers-reference.md) | [OWASP scenario map](owasp-scenarios.md) | [Optional MCP entity scans](12-mcp-entities.md)