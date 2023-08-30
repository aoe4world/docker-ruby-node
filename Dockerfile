FROM debian

ENV RUBY_MAJOR="3.2" \
  RUBY_VERSION="3.2.2" \
  RUBYGEMS_VERSION="3.4.19"

ARG PARALLELISM
ENV PARALLELISM ${PARALLELISM:-4}

WORKDIR /tmp

# install and uninstall packages
RUN apt-get update && \
  apt-get install -y gnupg2 curl apt-transport-https git ca-certificates libssl-dev gcc make zlib1g-dev libjemalloc-dev libjemalloc2 libpq-dev libyaml-dev && \
  apt-get remove --purge -y anacron cron openssh-server postfix && \
  apt-get autoremove --purge -

# install ruby
RUN curl -o ruby.tgz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz" && \
  tar -xzf ruby.tgz && \
  cd ruby-${RUBY_VERSION} && \
  ./configure --enable-shared --with-jemalloc --disable-install-doc && \
  make -j ${PARALLELISM} && \
  make install

# install node, yarn, and other tools
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -qq && \
    apt-get install -y postgresql-client nodejs redis-tools && \
    npm install -g yarn

# configure gems
RUN echo 'gem: --no-document' > $HOME/.gemrc && gem update --system ${RUBYGEMS_VERSION}

# delete apt related things to make container more lightweight
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt /var/lib/dpkg /usr/share/man /usr/share/doc
