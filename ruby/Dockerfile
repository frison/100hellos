# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN \
  sudo \
  apk add --no-cache \
    ruby-dev
#     # Node is needed for rails
#     nodejs npm \
#     # Rails build packages
#     curl-dev ruby-dev build-base bash \
#     # Rails gems
#     libpq-dev

# ENV GEM_HOME="/usr/local/bundle"
# RUN \
#   git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
#   && echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc \
#   && ~/.rbenv/bin/rbenv init - >> ~/.zshrc \
#   && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
#   && sudo mkdir -p $GEM_HOME && sudo chmod 777 -R $GEM_HOME

# ENV PATH="$GEM_HOME/bin:$GEM_HOME/gems/bin:$HOME/.rbenv/shims:$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/bin:$PATH"

# RUN \
#   rbenv install 3.1.2 \
#   && rbenv global 3.1.2

COPY --chown=human:human ./files /hello-world
