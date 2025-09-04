## Observability Services
The following document describes observability services integrated into the system.

### Grafana
Grafana is used for visualizing metrics, logs and traces collected from Prometheus, Loki, and Tempo in the cluster.   
Additionally, built-in Alertmanager is used for alerting based on the collected data.
- **Deployment:** https://grafana.o11y.local
- **Official Website:** https://grafana.com

### Prometheus
Prometheus is used for collecting and storing metrics from various services and applications running in the cluster.
- **Deployment:** https://prometheus.o11y.local
- **Official Website:** https://prometheus.io

### Alloy
Alloy is used for collecting logs in the cluster.
- **Deployment:** https://alloy.o11y.local
- **Official Docs:** https://grafana.com/docs/alloy/latest

### Loki
Loki is used for log aggregation and management in the cluster.
- **Official Website:** https://grafana.com/oss/loki

### Tempo
Tempo is used for distributed tracing in the cluster.
- **Official Website:** https://grafana.com/oss/tempo

### Rocket.Chat
The purpose of Rocket.Chat is to simulate platforms like Slack, Webex, or Microsoft Teams for alert notifications.  
- **Deployment:** https://rocket.o11y.local
- **Official Website:** https://rocket.chat