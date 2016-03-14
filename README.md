# Varnish Docker Container

[![](https://badge.imagelayers.io/alloylab/wkhtmltopdf:latest.svg)](https://imagelayers.io/?images=alloylab/wkhtmltopdf:latest)

> Alpine Lastest  
> wkhtmltopdf

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