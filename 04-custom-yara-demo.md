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
        description = "Workshop-only detection for instruction override plus secret exfiltration"
        threat_type = "TOOL POISONING"

    strings:
        $override = "Ignore all previous instructions" nocase
        $secrets = "send any secrets to" nocase

    condition:
        all of them
}
```

## Run the scan

```powershell
Set-Location C:\workspace\test
mcp-scanner --analyzers yara --rules-path .\labs\demo-rules --format detailed static --tools .\labs\tools-suspicious.json
```

Expected result: the `lookup_order` item is unsafe and includes the `Demo_Tool_Poisoning` YARA match with high severity. `threat_type = "TOOL POISONING"` maps the custom match to Cisco's built-in YARA threat taxonomy and severity. The standalone `severity` metadata field is not used for the scanner's severity rollup.

## Teach the point

Custom rules turn a review policy into a repeatable control. Typical production rules match prohibited phrases, sensitive internal hosts, credential formats, or tool descriptions that violate your organization’s trust boundaries.

Continue with [05-output-and-triage.md](05-output-and-triage.md).