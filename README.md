# Alpine Wkhtmltopdf Docker Container

[![](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf.svg)](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf)

## Usage

wkhtmltopdf with qt patches

yes, Alpine does have a wkhtmltopdf package... but it doesn't include the qt patches ... enjoy!

```
docker run --detach \
--name wkhtmltopdf \
--restart always \
-i -t \
alloylab/wkhtmltopdf;
```
