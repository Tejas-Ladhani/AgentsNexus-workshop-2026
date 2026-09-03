![AgentsNexus 2026](media/agentsnexus-logo-with-year-dark.svg)
---
# AgentsNexus 2026

Your agents are pulling from an unaudited ecosystem of third-party tools and skill servers. You have no visibility into what they can actually do. That's running completely unauthenticated code in production. The problem: Agents are shipping faster than security teams can secure them. Every tool, every skill, every MCP server is a potential attack surface. If you can't scan what your agent's tools are capable of, you're gambling.

More here: [AgentsNexus Agenda](http://agentsnexus.io/agenda?type=workshop)

## Hacking and Hardening AI Agents

**Hands-On Security Scanning for the Tool Ecosystem**

September 4, 2026 | 10:30 AM - 12:30 PM

Agents connect to an ecosystem of MCP servers, tools, prompts, resources, and external services. This hands-on lab demonstrates how to inspect that metadata, detect hostile tool descriptions, and compare deterministic rules with semantic LLM analysis.

## Setup (One Command)

**Windows (PowerShell):**

```powershell
.\setup.ps1
```

Installs `uv` (if missing), pins Python `3.13`, ensures Visual Studio C++ Build Tools (MSVC), installs the `mcp-scanner` CLI, and syncs the local FastMCP workshop server's dependencies.

Why MSVC on Windows: `mcp-scanner` depends on `yara-python` and a `litellm` component; Windows has no default C compiler, so if no prebuilt wheel matches your Python version, it compiles from source and needs the MSVC linker (`link.exe`). If `winget` cannot run on your machine (e.g., no admin rights), install the **Desktop development with C++** workload manually from [visualstudio.microsoft.com/visual-cpp-build-tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/), then rerun `.\setup.ps1`.

**macOS / Linux:**

```bash
chmod +x setup.sh && ./setup.sh
```

Installs `uv` (if missing), pins Python `3.13`, installs the `mcp-scanner` CLI, and syncs the workshop server's dependencies. macOS/Linux normally use prebuilt `yara-python` wheels for Python 3.13, so no compiler is required; if a build from source is ever triggered, run `xcode-select --install` (macOS) first.

Both scripts require no manual pip/venv steps.

### Semantic Analysis: LM Studio or Amazon Bedrock (Module 9, optional)

Module 9 needs one LLM provider, either is fine and both are documented in [09-llm-analysis.md](09-llm-analysis.md):

| | LM Studio | Amazon Bedrock |
| --- | --- | --- |
| Runs | Locally, on your laptop | Hosted on AWS |
| Data leaves your machine? | No | Yes, to AWS |
| Needs | LM Studio app + a loaded instruct model, `16384`+ token context | An AWS account/API key with Bedrock access, `boto3` |
| Result quality (this workshop) | Model-dependent, may miss findings | More consistent detections |

Pick one before the session so you are not installing/configuring it live.

### Install LM Studio

If LM Studio is not already installed, download it from the official [LM Studio download page](https://lmstudio.ai/download):

- Windows: download and run the Windows installer.
- macOS: download and open the macOS installer, then move LM Studio to Applications if prompted.
- Linux: use the Linux download provided on the download page and follow its installation instructions.

Open LM Studio, download the instruct model `qwen/qwen3-4b-2507`, and load it with a context length of at least `16384` tokens. In **Developer / Local Server**, select the model, set the port to `1234`, and start the server.

Verify that the local API is available:

```powershell
curl http://localhost:1234/v1/models
```

The complete provider configuration and scan commands are in [09-llm-analysis.md](09-llm-analysis.md).

## Start Here

Open the repository in VS Code or any IDE of your choice and run lab commands from the repository root. Follow the complete workshop sequence in [00-workshop-roadmap.md](00-workshop-roadmap.md).

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