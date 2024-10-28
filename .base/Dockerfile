# syntax=docker/dockerfile:1
# escape=\
ARG ALPINE_VERSION=3.18
FROM alpine:${ALPINE_VERSION} AS earth

# When there are upstream dependency changes that would not result
# in a rebuild of the image, we can explain why we need a rebuild here
# and force subsequent layers to rebuild.
RUN echo "2024-10-28 : New Clio Hackathon, rebuild them all!" > /tmp/cache-buster

RUN apk add --no-cache \
    ca-certificates \
    git \
    curl wget \
    openssh-client \
    zsh \
    sudo \
    make \
    jq \
    vim

# As we target alpine 3.10 and alpine 3.18 -- and sadly yq is not available
# in alpine 3.10 -- we only install yq if we are on alpine 3.18.
# We don't care about the extra layer because of the flattening at the bottom
# of the Dockerfile.
RUN [[ "${ALPINE_VERSION}" == "3.18" ]] && apk add --no-cache yq || true

# Create a group and user
RUN addgroup -S human \
    && adduser -S human -G human -G wheel -s zsh -h /home/human -D \
    # All members of wheel group to sudo without password
    && echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY --chown=human:human ./files /
RUN \
  chmod +x /usr/local/bin/* && \
  chmod +x /entrypoint.sh

USER human
WORKDIR /home/human
ENV HOME=/home/human
ENV PATH=/usr/local/bin:$PATH
ENV HOSTNAME=world

# Set home permissions and install oh-my-zsh
RUN \
  export ZSH=/home/human/.oh-my-zsh && \
  export ZDOTDIR=/home/human && \
  /usr/local/ohmyzsh/tools/install.sh --keep-zshrc --unattended

ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]

# This is how we flatten the image into a single layer
FROM scratch as base
COPY --from=earth / /

USER human
WORKDIR /home/human

ENV HOME=/home/human
ENV PATH=/usr/local/bin:$PATH
ENV HOSTNAME=world

ENTRYPOINT ["/entrypoint.sh"]

CMD ["zsh"]
