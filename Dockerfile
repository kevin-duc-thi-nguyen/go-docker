FROM golang:1.13 AS build-env
RUN mkdir /go/src/app && apk update && apk add git
ADD main.go /src/
WORKDIR /src
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o app .

FROM scratch
WORKDIR /app
COPY --from=build-env /src/app .
ENTRYPOINT [ "./app" ]
