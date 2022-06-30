FROM alpine:3.16 as build-env
RUN apk add --update --no-cache --force-overwrite crystal shards build-base musl-dev pcre-dev libxml2-dev openssl-dev  \
    openssl-libs-static tzdata yaml-static zlib-static

WORKDIR /app
COPY . /app

RUN shards install
RUN shards build --production --release --static --no-debug

FROM scratch

WORKDIR /app

ENV KEMAL_ENV production
ENV HTTP_PORT 80

COPY --from=build-env /app/bin/test_kube /app/test_kube

EXPOSE $HTTP_PORT

CMD ["/app/test_kube"]
