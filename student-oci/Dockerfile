FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="EduAmigaE-Game Student Environment"
LABEL org.opencontainers.image.description="Reproducible public student environment for EduAmigaE-Game"

ARG EVO_VERSION=3.9.4
ARG EVO_URL=https://github.com/dmcoles/EVO/releases/download/V3.9.4/evo394.lha
ARG EVO_SHA256=a7ebb0b8de6261d63e9416f9a385ee1973a67a84228a1370b4ad6dcd4fe21230

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      make \
      lhasa \
      unzip \
      xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/eduamigae-game/download /opt/eduamigae-game/evo \
 && curl -fL --retry 3 "$EVO_URL" -o /opt/eduamigae-game/download/evo.lha \
 && echo "$EVO_SHA256  /opt/eduamigae-game/download/evo.lha" | sha256sum -c - \
 && lha xw=/opt/eduamigae-game/evo /opt/eduamigae-game/download/evo.lha

WORKDIR /course

COPY student-oci/entrypoint.sh /usr/local/bin/eduamigae-game
RUN chmod 0755 /usr/local/bin/eduamigae-game

ENV EDUAMIGAE_EVO_ROOT=/opt/eduamigae-game/evo
ENV EDUAMIGAE_EVO_VERSION=$EVO_VERSION

ENTRYPOINT ["/usr/local/bin/eduamigae-game"]
CMD ["help"]
