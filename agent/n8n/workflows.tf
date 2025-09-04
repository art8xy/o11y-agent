locals {
  workflows = "${path.module}/workflows"
}

resource "n8n_workflow" "rocket" {
  workflow_json = templatefile("${local.workflows}/rocket.json", {
    rocket_credentials = {
      id   = n8n_credential.grafana_bot.id
      name = n8n_credential.grafana_bot.name
    }
  })
}

resource "n8n_workflow_activation" "rocket" {
  workflow_id = n8n_workflow.rocket.id
  active      = true
}

resource "n8n_workflow" "loki" {
  workflow_json = templatefile("${local.workflows}/loki.json", {
    mistral_credentials = {
      id   = n8n_credential.mistral.id
      name = n8n_credential.mistral.name
    }

    valkey_credentials = {
      id   = n8n_credential.valkey.id
      name = n8n_credential.valkey.name
    }

    minio_credentials = {
      id   = n8n_credential.minio.id
      name = n8n_credential.minio.name
    }
  })
}

resource "n8n_workflow_activation" "loki" {
  workflow_id = n8n_workflow.loki.id
  active      = true
}

resource "n8n_workflow" "tempo" {
  workflow_json = templatefile("${local.workflows}/tempo.json", {
    mistral_credentials = {
      id   = n8n_credential.mistral.id
      name = n8n_credential.mistral.name
    }

    valkey_credentials = {
      id   = n8n_credential.valkey.id
      name = n8n_credential.valkey.name
    }

    minio_credentials = {
      id   = n8n_credential.minio.id
      name = n8n_credential.minio.name
    }
  })
}

resource "n8n_workflow_activation" "tempo" {
  workflow_id = n8n_workflow.tempo.id
  active      = true
}

resource "n8n_workflow" "agent" {
  workflow_json = templatefile("${local.workflows}/agent.json", {
    mistral_credentials = {
      id   = n8n_credential.mistral.id
      name = n8n_credential.mistral.name
    }

    rocket_credentials = {
      id   = n8n_credential.agent_bot.id
      name = n8n_credential.agent_bot.name
    }

    n8n_credentials = {
      id   = n8n_credential.n8n.id
      name = n8n_credential.n8n.name
    }

    loki_workflow = {
      id = n8n_workflow.loki.id
    }

    tempo_workflow = {
      id = n8n_workflow.tempo.id
    }

    evaluations_table = {
      id = jsondecode(terracurl_request.evaluations.response).id
    }
  })
}

resource "n8n_workflow_activation" "agent" {
  workflow_id = n8n_workflow.agent.id
  active      = true
}