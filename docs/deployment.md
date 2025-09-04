## Deployment
The following instructions will guide you through deploying the infrastructure and agent into your Kubernetes cluster.

### Requirements
- [helm](https://helm.sh/docs/intro/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools)
- [tfswitch](https://tfswitch.warrensbox.com/Installation)
- [mkcert](https://github.com/FiloSottile/mkcert?tab=readme-ov-file#installation)

### Infrastructure
The infrastructure includes all the necessary components for the agent to work.  
We create self-trusted CA and TLS certificate for custom DNS records.  
All services are exposed via Gateway and can be accessed by DNS.

1. Create Kubernetes cluster and export kubeconfig.

2. Set gateway IP address. The default IP address is `127.0.0.10`
    ```
    export GATEWAY_IP=<address>
    ```

3. Add entries to your `/etc/hosts` file to resolve the gateway IP address.
    ```
    make hosts
    ```

4. Trust CA on you computer and create TLS certificate
    ```
    make mk-create
    ```

5. Deploy infrastructure
    ```
    make tf-apply approve=true dir=infra
    ```
    **Note:** If you see "Register your workspace" when accessing the Rocket.Chat, kill the rocketchat pod.

### AI Agent and Resources
Resources include the agent and all the necessary configurations for it to work.  
The agent workflows depend on Mistral AI models.  
If you want to use other providers, you will need to modify the agent configuration in n8n.

1. Complete [n8n setup](https://n8n.o11y.local)

2. Create [n8n API key](https://n8n.o11y.local/settings/api) and export it
    ```
    export N8N_API_KEY=<key>
    ```

3. (Optional) Create [Mistral API key](https://console.mistral.ai/home) and export it
    ```
    export MISTRAL_API_KEY=<key>
    ```

4. Deploy the agent
    ```
    make tf-apply approve=true dir=agent
    ```