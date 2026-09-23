FROM docker.io/pandoc/core:3 AS builder
WORKDIR /src
COPY . .
RUN sh build.sh

FROM quay.io/epheo/kiss:latest
COPY --from=builder /src/build/ /content/
