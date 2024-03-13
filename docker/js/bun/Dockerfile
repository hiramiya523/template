# bookworm-slim
FROM debian@sha256:d6a343a9b7faf367bd975cadb5c9af51874a8ecf1a2b2baa96877d578ac96722

RUN apt-get update && apt-get install -y ca-certificates curl unzip --no-install-recommends \
    && curl -fsSL https://bun.sh/install | bash \
    && apt-mark auto '.*' > /dev/null \
    && find /usr/local -type f -executable -exec ldd '{}' ';' \
    | awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); print so }' \
    | sort -u \
    | xargs -r dpkg-query --search \
    | cut -d: -f1 \
    | sort -u \
    | xargs -r apt-mark manual \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get clean

RUN mv /root/.bun/bin/* /usr/local/bin/
RUN groupadd --gid 1000 bun \
    && useradd --uid 1000 --gid bun --shell /bin/bash --create-home bun

WORKDIR /home/bun
USER bun
# want to use distoress image with multistage build
# FROM oven/bun:distroless