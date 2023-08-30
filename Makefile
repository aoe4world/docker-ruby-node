CPU_COUNT:=$(shell nproc)
ifeq ($(PARALLELISM),)
	PARALLELISM:=$(shell expr ${CPU_COUNT} / 2)
endif

build:
	docker build \
		-f Dockerfile \
		-t aoe4world/ruby:latest \
		-t aoe4world/ruby:3.2 \
		--build-arg PARALLELISM=${PARALLELISM} \
		--squash \
		.

deploy:
	docker push aoe4world/ruby:3.2
	docker push aoe4world/ruby:latest
