## Memory
In this scenario, we test the o11y Agent's ability to diagnose an issue based on the memory from previous runs.

### Steps
1. Use any of the [scenarios](../) to trigger an issue and let the o11y Agent post a report with insights about the issue.
2. Repeat the same scenario again and check if the o11y Agent used the memory from the previous run.
3. Open [n8n Console](https://n8n.o11y.local) and check the workflow execution history of either `loki` or `tempo`.