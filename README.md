# Alpine Wkhtmltopdf Docker Container

[![](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf.svg)](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf)
[![](https://images.microbadger.com/badges/image/madnight/docker-alpine-wkhtmltopdf.svg)](https://microbadger.com/images/madnight/docker-alpine-wkhtmltopdf "Get your own image badge on microbadger.com")

## Usage

wkhtmltopdf with qt patches

yes, Alpine does have a wkhtmltopdf package... but it doesn't include the qt patches ... enjoy!


```
# i do it myself
docker build -t alpine-wkhtmltopdf .
docker run alpine-wkhtmltopdf google.com - > test.pdf

# i'm lazy
docker run madnight/docker-alpine-wkhtmltopdf google.com - > test.pdf
```

## Q&A
*Is it really the smallest html to pdf docker image on the planet?*

Yes.



