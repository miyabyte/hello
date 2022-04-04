FROM golang:1.18-rc AS builder
LABEL stage=gobuilder

ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOPROXY https://goproxy.cn,direct

WORKDIR /build

COPY . .
RUN go mod download
RUN go build -ldflags="-s -w" -o hello main.go

FROM alpine

WORKDIR /app
COPY --from=builder /build/hello /app/hello

RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && apk update \
  && apk add vim \
  && apk add curl \
  && apk add busybox-extras

ENTRYPOINT ["./hello"]

#docker run -it --rm --name gohi -p 8000:8080  hihttp:v1 /bin/sh
#docker exec -it 67dab938715d /bin/sh




