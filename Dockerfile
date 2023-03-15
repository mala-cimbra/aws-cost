FROM golang:1 AS builder
WORKDIR /root/aws-cost
ADD . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build .

FROM alpine:3
LABEL maintainer="sergey.kondrashov@jetbrains.com"
LABEL maintainer="Ioma Taani"
RUN apk add ca-certificates gcompat && mkdir /app
WORKDIR /app
COPY --from=builder /root/aws-cost/aws-cost /app
ENTRYPOINT ["/app/aws-cost"]
