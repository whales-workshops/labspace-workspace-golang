FROM --platform=$BUILDPLATFORM dockersamples/labspace-workspace-base:latest

USER root

ARG TARGETOS
ARG TARGETARCH

# ------------------------------------
# Install Go
# ------------------------------------
ARG GO_VERSION=1.25.1
ARG TINYGO_VERSION=0.39.0
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
mkdir -p /go/pkg/mod
mkdir -p /go/bin
chown -R 1000:1000 /go
EOF

# ------------------------------------
# Install TinyGo
# ------------------------------------
RUN <<EOF
wget https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo_${TINYGO_VERSION}_${TARGETARCH}.deb
dpkg -i tinygo_${TINYGO_VERSION}_${TARGETARCH}.deb
rm tinygo_${TINYGO_VERSION}_${TARGETARCH}.deb
EOF


USER 1000

#Install Go Language Server as user
ENV GOPATH="/go"
ENV PATH="$PATH:/go/bin"
RUN go install golang.org/x/tools/gopls@latest


RUN <<EOF
code-server --install-extension golang.go
rm -rf /home/coder/.local/share/code-server/CachedExtensionVSIXs/.trash/*
EOF

