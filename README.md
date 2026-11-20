# Ruby + Node Docker Image

Docker image with Ruby (with jemalloc) and Node.js (with Yarn).

## Variants

* Ruby 3.3.14 + Node 20: `aoe4world/ruby:3.3.14`

Ruby 3.3.14 includes the Ruby2Shell (GHSA-34m4-m9fh-gqp5) fix. The build
verifies the source archive against the SHA-256 published by the Ruby project.

Build with `make build`, verify `docker run --rm aoe4world/ruby:3.3.14 ruby -v`,
then publish with `make deploy`. Rebuild and roll out dependent application
images after publishing; existing containers retain their previous runtime.

Release builds target `linux/amd64`, matching Cloud Build. For a local ARM build,
use `make build PLATFORM=linux/arm64`; do not publish that single-platform image
over the release tag.
