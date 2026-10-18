# Stage 1: build a static Go binary.
# Runs on the build host's platform and cross-compiles for the target one,
# so the same Dockerfile produces images for amd64 (GKE) and arm64 (Apple Silicon).
FROM --platform=$BUILDPLATFORM golang:1.27 AS builder
ARG TARGETOS
ARG TARGETARCH
WORKDIR /src
COPY src .
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o app

# Stage 2: empty base image with only the binary and the content.
FROM scratch
ADD ./html /html
COPY --from=builder /src/app /app
EXPOSE 8080
ENTRYPOINT ["/app"]
