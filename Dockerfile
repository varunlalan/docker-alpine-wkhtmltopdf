FROM alpine:3.10
MAINTAINER Fabian Beuke <mail@beuke.org>

RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

# on alpine static compiled patched qt headless wkhtmltopdf (46.8 MB)
# compilation takes quiet some time on i7-8550U in 2019 thats why binary
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10 /bin/wkhtmltopdf /bin/wkhtmltopdf

ENTRYPOINT ["wkhtmltopdf"]
