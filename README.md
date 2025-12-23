# Labspace Workspace Golang Environment

```bash
docker pull philippecharriere494/labspace-workspace-golang:1.25.4_0.0.0
```

## Release

- Update the `TAG` variable in `docker-bake.hcl`
- `docker buildx bake --push --file docker-bake.hcl`
- Update the `DOCKER_TAG` variable in `release.env`
- Update the `README.md` with the new version
- Run `release.sh` 