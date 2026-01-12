
variable "REPO" {
  default = "philippecharriere494"
}

variable "TAG" {
  default = "1.25.5_0.0.1"
}

group "default" {
  targets = ["labspace-workspace-golang"]
}

target "labspace-workspace-golang" {
  context = "."
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = ["${REPO}/labspace-workspace-golang:${TAG}"]
}

# docker buildx bake --push --file docker-bake.hcl
# docker buildx bake --file docker-bake.hcl