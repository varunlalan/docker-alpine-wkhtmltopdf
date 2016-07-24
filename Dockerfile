FROM alpine:latest
MAINTAINER Fabian Beuke <mail@beuke.org>

# testing repositories contain fonts
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl fonts-base && \
    rm -rf /var/cache/apk/*
	
# on alpine static compiled patched qt headless wkhtmltopdf (47.2 MB)
ADD wkhtmltopdf /

ENTRYPOINT ["./wkhtmltopdf"]

