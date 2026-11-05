# Stage 1: official Xray image (distroless, no shell) - take only the binary
FROM ghcr.io/xtls/xray-core:latest AS xray

# Stage 2: Alpine runtime with a shell
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
