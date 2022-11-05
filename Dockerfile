FROM debian

ENV RUBY_MAJOR="3.1" \
  RUBY_VERSION="3.1.2" \
  RUBYGEMS_VERSION="3.3.24"

WORKDIR /tmp

# RUN apt update
# RUN apt search postgresql-client
# RUN exit 1

# install and uninstall packages
RUN apt-get update && \
  apt-get install -y gnupg2 curl apt-transport-https git ca-certificates libssl-dev gcc make zlib1g-dev libjemalloc-dev libjemalloc2 libpq-dev && \
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
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update -qq && \
    apt-get install -y postgresql-client nodejs redis-tools && \
    npm install -g yarn

# delete apt related things to make container more lightweight
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt /var/lib/dpkg /usr/share/man /usr/share/doc
