# Alpine runtime with a shell; xray binary copied straight from the official image.
# (Named multi-stage COPY --from=xray fails on Cloady's builder with
# "failed to calculate checksum of ref", even though the image pulls fine,
# so reference the image directly instead of via a named stage.)
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=ghcr.io/xtls/xray-core:latest /usr/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
