.PHONY: build

build:
	docker build \
		--label=com.opendatagroup.fastscore.product.branch=$(shell git rev-parse --abbrev-ref HEAD) \
		--label=com.opendatagroup.fastscore.product.tag=$(shell git describe --tags) \
		--label=com.opendatagroup.fastscore.product.repo=kafka \
		-t fastscore/kafka:dev \
		-t local/kafka \
		-f Dockerfile\
		.
