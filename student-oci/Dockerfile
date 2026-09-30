FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="EduAmigaE-Game Student Environment"
LABEL org.opencontainers.image.description="Reproducible public student environment for EduAmigaE-Game"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      make \
      unzip \
      xz-utils \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /course

# The Amiga E compiler/toolchain is intentionally not downloaded from an
# unverified URL here. M1 will pin a redistributable/public source and verify
# its checksum before the image is declared course-ready.

COPY student-oci/entrypoint.sh /usr/local/bin/eduamigae-game
RUN chmod 0755 /usr/local/bin/eduamigae-game

ENTRYPOINT ["/usr/local/bin/eduamigae-game"]
CMD ["help"]
