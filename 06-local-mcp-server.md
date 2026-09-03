# Module 6 - Ready-Made MCP Security Workshop Server

The workshop includes one local MCP server in `labs/customer-operations-server`. Attendees do not need to build their own server. It is a functional customer-operations service with local order, status, support, and approval workflows.

## What the server contains

`server.py` uses **FastMCP** and exposes tools, a prompt, a resource, and server instructions via HTTP on `localhost:8000`. The customer-operations tools cover order lookup and search, service status, customer-summary export, support-ticket creation, and approval-based account-action requests. It uses local in-memory records, so it behaves like an application without external credentials or services.

The server includes four deliberately unsafe-looking tool descriptions so the live remote scan has observable findings. Their Python implementations are inert: they return a status response only, with no network calls, secret access, file access, or command execution. The offline fixtures remain the deterministic custom-YARA exercise.

## One-time preparation

From the server directory, install FastMCP and dependencies:

```powershell
Set-Location C:\workspace\test\labs\customer-operations-server
uv sync
```

## Start the HTTP server

Launch the server on HTTP:

```powershell
uv run server.py
```

The server will print:
```
Uvicorn running on http://127.0.0.1:8000
```

Leave it running in this terminal. The server is now ready for remote scanning in Module 7.