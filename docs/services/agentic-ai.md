## Agentic AI Services
The following document describes services that enable Agentic AI capabilities.

### n8n
n8n allows AI Models to interact with various APIs and services through workflows.  
- **Deployment:** https://n8n.o11y.local
- **Official Website:** https://n8n.io

### Valkey
Valkey provides memory management for AI Agent.
- **Official Website:** https://valkey.io

### Minio
Minio is used as object storage for Agent Context.
- **Deployment:** https://minio.o11y.local
- **API Endpoint:** https://minio-api.o11y.local
- **Official Website:** https://min.io

### Grafana MCP
Grafana MCP allows AI Agent to interact with Grafana, Prometheus, Loki and Tempo deployments.  
- **Deployment:** https://grafana-mcp.o11y.local/mcp
- **Official Repository:** https://github.com/grafana/mcp-grafana

#### VS Code Config
```
{
    "servers": {
        "grafana": {
            "type": "http",
            "url": "https://grafana-mcp.o11y.local/mcp"
        }
    }
}
```