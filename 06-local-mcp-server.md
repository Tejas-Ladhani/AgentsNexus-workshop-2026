# Module 6 - Ready-Made MCP Security Workshop Server

The workshop includes one local MCP server in `labs/customer-operations-server`. Attendees do not need to build their own server. It is a functional customer-operations service with local order, status, support, and approval workflows.

## What the server contains

`server.py` uses **FastMCP** and exposes 13 tools, 3 prompts, 1 resource, 2 resource templates, and server instructions via HTTP on `localhost:8000`. The customer-operations tools cover order lookup and search, service status, customer-summary export, support-ticket creation, and approval-based account-action requests. It uses local in-memory records, so it behaves like an application without external credentials or services.

The server includes three additional safe listing tools and one harmless declaration/implementation mismatch for behavioral-analysis exploration, plus four deliberately unsafe-looking tool descriptions so the live remote scan has observable findings. Their Python implementations are inert: they return local status data only, with no network calls, secret access, file access, or command execution. The offline fixtures remain the deterministic custom-YARA exercise.

## One-time preparation

From the repository root, install FastMCP and dependencies:

```powershell
uv sync --directory labs/customer-operations-server
```

## Start the HTTP server

Launch the server on HTTP:

```powershell
uv run --directory labs/customer-operations-server server.py
```

The server will print:
```
Uvicorn running on http://127.0.0.1:8000
```

Leave it running in this terminal. The server is now ready for remote scanning in Module 7.

## Inspect with MCP Dev

To explore the server interactively in MCP Inspector, stop the HTTP process or use a separate terminal and run:

```powershell
uv run --directory labs/customer-operations-server mcp dev server.py
```

In MCP Inspector, confirm that the server exposes 14 tools, the `support_reply`, `ticket_update`, and `incident_summary` prompts, and the `customer://orders/{order_id}`, `customer://customers/{customer_id}`, and `customer://services/status` resources. The first two are resource templates. Explore `list_services`, `list_customer_ids`, and `list_orders` first, then call `lookup_order` with `ORD-1001`; the response should include `CUST-100`, `shipped`, and `89.00`. The `lookup_delivery_window` tool is intentionally mismatched for the behavioral lab.

Close MCP Inspector when finished, then start the HTTP server again before continuing to Module 7.