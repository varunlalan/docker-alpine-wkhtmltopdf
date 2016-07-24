# Alpine Wkhtmltopdf Docker Container

[![](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf.svg)](https://travis-ci.org/madnight/docker-alpine-wkhtmltopdf)

## Usage

wkhtmltopdf with qt patches

yes, Alpine does have a wkhtmltopdf package... but it doesn't include the qt patches ... enjoy!

```
docker build -t alpine-wkhtmltopdf .
docker run alpine-wkhtmltopdf google.com - > test.pdf
```
## Notes

Size of the image is: 95.5 MB (wkhtmltopdf 47.2 MB)

