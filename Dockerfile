FROM --platform=$BUILDPLATFORM dockersamples/labspace-workspace-base:latest

USER root

ARG TARGETOS
ARG TARGETARCH

# ------------------------------------
# Install Go
# ------------------------------------
ARG GO_VERSION=1.25.5

RUN <<EOF
wget https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz
tar -xzf go${GO_VERSION}.linux-${TARGETARCH}.tar.gz -C /usr/local
rm go${GO_VERSION}.linux-${TARGETARCH}.tar.gz
EOF

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV GOROOT="/usr/local/go"

RUN <<EOF
mkdir -p /go/pkg/mod/cache
mkdir -p /go/bin
chmod -R 775 /go
chown -R 1000:1000 /go
EOF

USER 1000

#Install Go Language Server as user
ENV GOPATH="/go"
ENV PATH="$PATH:/go/bin"
RUN go install golang.org/x/tools/gopls@latest

USER root
RUN chmod -R 775 /go
USER 1000


RUN <<EOF
code-server --install-extension golang.go
rm -rf /home/coder/.local/share/code-server/CachedExtensionVSIXs/.trash/*
EOF

