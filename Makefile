CPU_COUNT:=$(shell nproc)
PLATFORM ?= linux/amd64
ifeq ($(PARALLELISM),)
	PARALLELISM:=$(shell expr ${CPU_COUNT} / 2)
endif

build:
	docker build \
		--platform $(PLATFORM) \
		-f Dockerfile \
		-t aoe4world/ruby:3.3.14 \
		--build-arg PARALLELISM=${PARALLELISM} \
		.

deploy:
	docker push aoe4world/ruby:3.3.14
