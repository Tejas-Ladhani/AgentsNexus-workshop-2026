# Module 9 - Semantic LLM Analysis

Cisco MCP Scanner uses LiteLLM, so the same live FastMCP server can be reviewed with either a local LM Studio model or Amazon Bedrock. The model receives tool metadata only; it does not execute tools or follow URLs in their descriptions.

Use the custom YARA rule from Module 7 for deterministic detection. Semantic results vary by model, prompt, and provider.

## Option A: Local LM Studio

LM Studio keeps tool metadata on your machine. Load an instruct model with a context length of at least `16384` tokens, then start its local server on port `1234`. The scanner uses a fixed analysis prompt that can exceed smaller context windows.

Confirm the loaded model identifier:

```powershell
curl http://localhost:1234/v1/models
```

The workshop model ID is `qwen/qwen3-4b-2507`. LiteLLM requires the OpenAI-compatible provider prefix, so configure it as `openai/qwen/qwen3-4b-2507`.

Configure the scanner for the current terminal only. `local` is a non-secret placeholder required by the scanner:

```powershell
$env:MCP_SCANNER_LLM_API_KEY = "local"
$env:MCP_SCANNER_LLM_MODEL = "openai/qwen/qwen3-4b-2507"
$env:MCP_SCANNER_LLM_BASE_URL = "http://localhost:1234/v1"
$env:MCP_SCANNER_DEFAULT_LLM_MAX_TOKENS = "256"
```

If LM Studio returns `Context size has been exceeded`, reload the model with at least a `16384`-token context window and restart its local server.

## Option B: Amazon Bedrock

Bedrock is useful when you want a stronger hosted model and more consistent semantic classifications. It sends tool metadata to AWS; use it only when that is allowed by your data-handling policy.

Install the Bedrock SDK dependency once in the existing scanner environment:

```powershell
C:\Users\JDV376\AppData\Roaming\uv\tools\cisco-ai-mcp-scanner\Scripts\python.exe -m pip install boto3
```

Clear the local endpoint settings, select a Bedrock model you have enabled in your AWS region, then use either an Amazon Bedrock API key or standard AWS credentials:

```powershell
Remove-Item Env:MCP_SCANNER_LLM_BASE_URL -ErrorAction SilentlyContinue

$env:MCP_SCANNER_LLM_MODEL = "bedrock/us.anthropic.claude-haiku-4-5-20251001-v1:0"
$env:AWS_REGION = "ap-southeast-2"
```

For Amazon Bedrock API-key authentication, use exactly one of the following environment variables with an `ABSK...` Bedrock API key. Do not put the key in a file or share it in chat. An AWS access key ID such as `AKIA...` is not a Bedrock API key.

Use `MCP_SCANNER_LLM_API_KEY` when configuring the scanner directly:

```powershell
$bedrockApiKey = Read-Host "Enter Amazon Bedrock API key" -AsSecureString
$env:MCP_SCANNER_LLM_API_KEY = [System.Net.NetworkCredential]::new("", $bedrockApiKey).Password
Remove-Variable bedrockApiKey
```

Or use the AWS Bedrock bearer-token variable:

```powershell
$bedrockApiKey = Read-Host "Enter Amazon Bedrock API key" -AsSecureString
$env:AWS_BEARER_TOKEN_BEDROCK = [System.Net.NetworkCredential]::new("", $bedrockApiKey).Password
Remove-Variable bedrockApiKey
```

If both variables are set, `MCP_SCANNER_LLM_API_KEY` takes precedence. Clear it before using `AWS_BEARER_TOKEN_BEDROCK`:

```powershell
Remove-Item Env:MCP_SCANNER_LLM_API_KEY -ErrorAction SilentlyContinue
```

Alternatively, set neither key variable; the scanner will use AWS credentials from a configured profile, AWS SSO, environment credentials, or an IAM role.

## Run semantic analysis

With either option configured, analyze the live remote server:

```powershell
mcp-scanner --analyzers llm --format detailed remote --server-url http://127.0.0.1:8000/mcp
```

Expected outcome: the command reports `llm_analyzer` findings for the four intentionally unsafe metadata samples. In this workshop, Bedrock produced more reliable classifications than the small local model. Compare semantic findings with the deterministic YARA result from [04-custom-yara-demo.md](04-custom-yara-demo.md).

## Clear the terminal configuration

```powershell
Remove-Item Env:MCP_SCANNER_LLM_API_KEY
Remove-Item Env:MCP_SCANNER_LLM_MODEL
Remove-Item Env:MCP_SCANNER_LLM_BASE_URL
Remove-Item Env:AWS_REGION
Remove-Item Env:AWS_BEARER_TOKEN_BEDROCK
```

## Next

Continue with [10-known-configs.md](10-known-configs.md) only when you are ready to inspect MCP configurations on this machine.