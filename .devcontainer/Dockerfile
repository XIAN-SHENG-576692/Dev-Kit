FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update -y && apt-get install -y \
    git \
    gh \
    && rm -rf /var/lib/apt/lists/*

CMD ["sleep", "infinity"]
