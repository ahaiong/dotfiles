FROM nixos/nix:2.28.3

ENV NIX_PATH=nixpkgs=channel:nixos-unstable
ENV LANG=C.UTF-8
ENV TERMINAL=xterm-256color

WORKDIR /workspace

COPY default.nix /opt/nix-shell/default.nix

RUN useradd --create-home --user-group --shell /bin/bash --groups nix-users developer \
    && mkdir -p /home/developer/.logs /nix/var/nix/profiles/per-user/developer \
    && chown -R developer:developer /home/developer /nix/var/nix/profiles/per-user/developer /workspace

ENV HOME=/home/developer
ENV USER=developer

USER developer

ENTRYPOINT [ "nix-shell", "/opt/nix-shell/default.nix" ]
