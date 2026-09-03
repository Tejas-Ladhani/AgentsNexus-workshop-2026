# MCP Scanner Analyzer Reference

Use `--analyzers` to select analysis engines:

```powershell
mcp-scanner --analyzers yara --format detailed static --tools .\labs\tools.json
```

The installed scanner's readiness heuristics are deferred in this workshop because they do not interpret standard FastMCP remote metadata. See [08-live-readiness.md](08-live-readiness.md).

Use `--analyzer-filter` only after a scan to limit displayed results from a particular analyzer:

```powershell
mcp-scanner --analyzer-filter yara_analyzer --format detailed static --tools .\labs\tools.json
```

## YARA

`yara` matches deterministic patterns in tool metadata, prompts, resources, and supported scan inputs. It is fast, local, repeatable, and needs no credentials.

Use it for: baseline CI checks, known dangerous patterns, and custom organization rules passed with `--rules-path`.

It can detect: patterns associated with prompt injection, code execution, command or script injection, credential harvesting, data exfiltration, system manipulation, and tool poisoning.

Limitation: a non-match means none of the loaded rules matched. It is not proof that an item is safe.

## Prompt Defense

`prompt_defense` uses local regular expressions to assess whether a tool description or server instruction includes defenses against common prompt attack vectors. It needs no credentials.

It checks for defenses related to: instruction override, data leakage, role escape, indirect injection, output weaponization and manipulation, multilingual or Unicode bypass, context overflow, social engineering, input validation, and abuse prevention.

Use it for: live server tools and instructions where you want to identify missing security guidance.

Limitation: it identifies missing defensive language; it does not establish that the implementation enforces those defenses. In the current static CLI exercise, only the YARA result was displayed, so confirm analyzer coverage on the target mode before using it as a CI gate.

## Readiness

`readiness` evaluates production reliability with local heuristics and needs no credentials. It complements security analysis rather than replacing it.

It checks for: missing or excessive timeouts, unlimited retries, missing backoff, incomplete error schemas, vague descriptions, overly broad tool scope, missing required inputs, missing rate limits or versioning, missing observability, resource cleanup gaps, dangerous operation keywords, and self-reference risks.

It assigns a readiness score from 0 to 100. A tool is production-ready when the score is at least 70 and has no critical finding.

Use it for: pre-production quality gates and design review of tools that call external systems.

Limitation: heuristics infer evidence from the supplied metadata or server; they cannot verify runtime reliability under real load.

## LLM

`llm` performs semantic analysis of MCP tools, prompts, resources, and instructions. It can identify concerns that exact YARA patterns miss, such as deceptive descriptions and subtle tool poisoning.

Requirements: an LLM endpoint plus `MCP_SCANNER_LLM_MODEL` and provider authentication. A local OpenAI-compatible endpoint such as LM Studio can use `MCP_SCANNER_LLM_API_KEY`; Amazon Bedrock can use `MCP_SCANNER_LLM_API_KEY`, `AWS_BEARER_TOKEN_BEDROCK`, or standard AWS credentials. See [09-llm-analysis.md](09-llm-analysis.md).

Use it for: deeper review after deterministic checks, and for workshop comparisons between pattern matching and semantic interpretation.

Limitation: results can vary by model, prompt, context window, configuration, and model quality. Preserve the model ID and scanner version with a report when using results for governance.

## Cisco AI Defense API

`api` sends content to the Cisco AI Defense inspection service for its security analysis.

Requirements: a Cisco AI Defense subscription, `MCP_SCANNER_API_KEY`, and optionally `MCP_SCANNER_ENDPOINT` for a non-default Cisco endpoint.

Use it for: organizations using AI Defense that need Cisco-managed detection and reporting alongside local analysis.

Limitation: this is not offline. Confirm data-handling and regional requirements before sending tool metadata.

## Behavioral

`behavioral` analyzes MCP server source code and compares actual behavior with declared tool intent. It supports Python, TypeScript, JavaScript, Go, Java, Kotlin, C#, Rust, Ruby, and PHP.

Requirements: an LLM configuration. Invoke it with a path:

```powershell
mcp-scanner behavioral .\path\to\mcp-server --format detailed
```

See the workshop exercise in [13-behavioral-analysis.md](13-behavioral-analysis.md).

Use it for: detecting discrepancies such as a benign-looking tool description paired with code that accesses secrets, performs undeclared network calls, or executes commands.

Limitation: it is source-based analysis, so it cannot see closed-source dependencies or behavior created only at runtime.

## VirusTotal

`virustotal` performs SHA-256 hash lookups for suspicious files and packaged MCP-server assets.

Requirements: `VIRUSTOTAL_API_KEY`. Unknown-file uploading is disabled by default and should remain an explicit privacy decision.

Use it for: reviewing archives, binaries, PDFs, and similar bundled artifacts.

Limitation: a hash lookup cannot assess new or unknown malware without an explicit upload, and it sends hash information to the external service.

## Vulnerable Package

`vulnerable_package` uses `pip-audit` to identify known CVE, PYSEC, and GHSA issues in a Python requirements file or project. It needs no API key but queries vulnerability data unless using an available local cache.

```powershell
mcp-scanner vulnerable-package .\path\to\requirements.txt --format detailed
```

Use it for: dependency supply-chain reviews before deploying an MCP server.

Limitation: it reports known published vulnerabilities, not malicious behavior or undisclosed vulnerabilities. Do not use `--fix` in a workshop unless dependency updates are intentionally in scope.

## Meta Analyzer

`meta` is a second LLM pass that reviews findings from other analyzers, correlates related evidence, prioritizes risk, and can reduce false positives.

Requirements: an LLM configuration. Enable it with `--enable-meta`.

Use it for: analyst workflows where evidence from multiple analyzers needs review.

Limitation: it inherits the variability and data-handling considerations of the configured LLM.

## Practical Workshop Profiles

| Profile | Command selection | Reason |
| --- | --- | --- |
| Offline baseline | `--analyzers yara` | Fast, repeatable, no credentials |
| Reliability review | Deferred for FastMCP remote targets in this workshop | Scanner heuristic compatibility limitation |
| Local semantic review | `--analyzers yara,llm` | Deterministic match plus local model interpretation |
| AI Defense deployment | `--analyzers api,yara,llm,readiness` | Broad coverage where the required services are approved |