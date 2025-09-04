## Context
In this scenario, we test the o11y Agent's ability to diagnose an issue based on additional context provided by the engineering team.  
The context is available in the [Context Documents](../../../agent/minio/context/Recommendation%20High%20Error%20Rate).

### Steps
1. Open [Feature Flags](https://otel-demo.o11y.local/feature) and enable the following flags:
    - `recommendationCacheFailure`
2. Open [Grafana Dashboard](https://grafana.o11y.local) and wait for the `Recommendation High Error Rate` alert to trigger.  
**Note:** You can find the observability panels in the `Recommendation` section.
3. Open [Alerts Channel](https://rocket.o11y.local/Alerts) and wait for the alert notification to arrive.  

After some time, the o11y Agent will post a report with insights about the issue.

### Example Report
![Example Report](../reports/Recommendation_High_Error_Rate.png)