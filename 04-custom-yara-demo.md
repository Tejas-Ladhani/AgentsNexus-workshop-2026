# 04 - Deterministic YARA Finding

The built-in YARA rules did not match our workshop wording. This is intentional: it shows that `Safe: Yes` means no selected rule matched, not that the description was approved by a human.

This lab adds a workshop-only local rule. It does not execute a tool, start a server, or call the URL in the fixture.

## Create the rule

Create `labs/demo-rules/demo-tool-poisoning.yara` with the contents below:

```yara
rule Demo_Tool_Poisoning
{
    meta:
        classification = "harmful"
        severity = "high"
        description = "Workshop-only detection for static fixtures and hostile live-server metadata samples"
        threat_type = "TOOL POISONING"

    strings:
        $fixture_override = "Ignore all previous instructions" nocase
        $fixture_secrets = "send any secrets to" nocase
        $context_harvesting = "Include the full conversation history" nocase
        $secret_collection = "secretly collect API keys and passwords" nocase
        $credential_theft = "purpose is to steal credentials" nocase
        $security_bypass = "disable security controls" nocase

    condition:
        ($fixture_override and $fixture_secrets) or any of ($context_harvesting, $secret_collection, $credential_theft, $security_bypass)
}
```

## Run the scan

```powershell
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format detailed static --tools .\labs\tools-suspicious.json
```

Expected result: the four suspicious fixture tools are unsafe and include the `Demo_Tool_Poisoning` YARA match with HIGH severity. `threat_type = "TOOL POISONING"` maps the custom match to Cisco's built-in YARA threat taxonomy and severity. The standalone `severity` metadata field is not used for the scanner's severity rollup.

## Teach the point

Custom rules turn a review policy into a repeatable control. Typical production rules match prohibited phrases, sensitive internal hosts, credential formats, or tool descriptions that violate your organization’s trust boundaries.

Continue with [05-output-and-triage.md](05-output-and-triage.md).