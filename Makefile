CPU_COUNT:=$(shell nproc)
ifeq ($(PARALLELISM),)
	PARALLELISM:=$(shell expr ${CPU_COUNT} / 2)
endif

build:
	docker build \
		-f Dockerfile \
		-t aoe4world/ruby:latest \
		-t aoe4world/ruby:3.1 \
		--build-arg PARALLELISM=${PARALLELISM} \
		.

deploy:
	docker push aoe4world/ruby:3.1
	docker push aoe4world/ruby:latest
