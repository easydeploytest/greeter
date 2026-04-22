# my-app

Deployed on [EasyDeploy](https://github.com/easydeploytest/EasyDeploy) — k3s + ArgoCD + Infisical + OTEL → Grafana Cloud.

| | |
|---|---|
| **Dev** | https://my-app-dev.easy-deploy.135.181.177.246.nip.io |
| **Prod** | https://my-app.easy-deploy.135.181.177.246.nip.io |
| **ArgoCD** | https://argocd.easy-deploy.135.181.177.246.nip.io/applications?search=my-app |
| **Infisical** | https://infisical.easy-deploy.135.181.177.246.nip.io — project **my-app** |
| **Grafana** | https://shanzindlr.grafana.net |

## Getting started

1. Edit `app.yaml` — set `name`, `team`, `port` to match your app
2. Write your app in `src/` and update `Dockerfile`
3. Push to `main` — CI builds the image and deploys to dev automatically

## Deploying to prod

Publish a GitHub Release with tag `v<version>` (e.g. `v1.0.0`).
CI re-tags the latest image as that version and ArgoCD syncs the prod namespace.

## Secrets

Add secrets in [Infisical](https://infisical.easy-deploy.135.181.177.246.nip.io) → project **my-app** → environment **dev** or **prod**.
They appear in your app as environment variables within ~5 minutes, no redeploy needed.

## Required GitHub Secrets

Set these once under **Settings → Secrets and variables → Actions** (org-level covers all repos):

| Secret | Description |
|--------|-------------|
| `ARGOCD_PASSWORD` | ArgoCD admin password |
| `INFISICAL_CLIENT_ID` | Infisical machine identity client ID |
| `INFISICAL_CLIENT_SECRET` | Infisical machine identity client secret |
| `INFISICAL_IDENTITY_ID` | Infisical machine identity ID |

## How it works

```
push to main
  → CI builds Docker image → pushes to registry.easy-deploy.135.181.177.246.nip.io
  → CI creates Infisical project (idempotent)
  → CI creates k8s namespaces + infisical-auth secrets
  → CI updates values-dev.yaml with new image tag → commits back
  → CI applies ArgoCD ApplicationSet → triggers sync
  → ArgoCD deploys → sends ntfy notification when pod is healthy
```
