.PHONY: docker layer clean test

docker:
	docker build --build-arg "DOTNET_VERSION=$(DOTNET_VERSION)" . -t layer
	docker run --rm -td --name lambda -v $(shell pwd):/tmp/build layer bash

layer:
	docker exec lambda bash -c "cd /opt && zip -yrq9 /tmp/build/layer.zip ."

clean:
	rm -fv layer.zip
	rm -rf layer/
	docker kill lambda

test:
	unzip -qo layer.zip -d layer

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.8 test.handler '{"some": "data"}'

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.7 test.handler '{"some": "data"}'

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.6 test.handler '{"some": "data"}'
