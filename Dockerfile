FROM alpine:latest as build-env

RUN apk update && apk add crystal shards build-base libressl-dev zlib-dev upx

WORKDIR /app
COPY . /app

RUN shards install && shards build --production --release --static && strip bin/test_kube && upx -9 bin/test_kube

FROM scratch

WORKDIR /app

ENV KEMAL_ENV production
ENV HTTP_PORT 80

COPY --from=build-env /app/bin/test_kube /app/test_kube

EXPOSE $HTTP_PORT

CMD ["/app/test_kube"]
