# Labspace Workspace Golang Environment

```bash
docker pull philippecharriere494/labspace-workspace-golang:1.25.1_0.0.0
```

## Release

- Update the `TAG` variable in `docker-bake.hcl`
- `docker buildx bake --push --file docker-bake.hcl`
- Run `release.sh` 