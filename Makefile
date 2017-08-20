run:
	docker run -it --rm osdev

build: Dockerfile
	docker build -t osdev -f Dockerfile .
