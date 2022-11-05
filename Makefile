build:
	docker build -f Dockerfile -t aoe4world/ruby:latest -t aoe4world/ruby:3.1 .

deploy:
	docker push aoe4world/ruby:3.1
	docker push aoe4world/ruby:latest
