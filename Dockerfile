# Alpine runtime with a shell; xray binary copied straight from the official image.
# The official image (distroless) keeps the binary at /usr/local/bin/xray, NOT /usr/bin/xray
# (Cloady build error '"/usr/bin/xray": not found' proved it; upstream image docs confirm /usr/local/bin).
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=ghcr.io/xtls/xray-core:latest /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
