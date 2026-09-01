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