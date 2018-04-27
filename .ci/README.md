## Concourse pipeline

Deployment:

```bash
fly -t prod-cloudops set-pipeline -p telia-terraform-modules -c ./.ci/pipeline.yml
fly -t prod-cloudops unpause-pipeline -p telia-terraform-modules
```

Destroy:

```bash
fly -t prod-cloudops destroy-pipeline -p telia-terraform-modules
```

Expose:

```bash
fly -t prod-cloudops expose-pipeline --pipeline telia-terraform-modules
# Revert with: fly -t prod-cloudops hide-pipeline --pipeline telia-terraform-modules
```

### Required secrets

- Access token for setting status on PR's.
- Deploy key for pulling the repository.
