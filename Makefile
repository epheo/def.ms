.PHONY: html serve image clean

html:
	sh build.sh

serve: html
	podman run --rm -p 8080:8080 -v ./build:/content:ro,z quay.io/epheo/kiss:latest

image:
	podman build -t def-ms .

clean:
	rm -rf build
