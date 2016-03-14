FROM alpine:latest

# install git & patch packages #
RUN apk add --update \
	git patch

# install qt build packages #
RUN apk add --update \
	make g++ mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libxrender-dev alsa-lib-dev openssl-dev fontconfig-dev freetype-dev \
	glib-dev libpng-dev zlib-dev sqlite-dev dbus-dev postgresql-dev mariadb-dev unixodbc-dev cups-dev gtk+-dev tiff-dev libmng-dev \
	libxrandr-dev libxv-dev libxi-dev perl gawk paxmark rsync freetds-dev hicolor-icon-theme mesa-gl
	
# wkhtmltopdf #
RUN git clone --recursive https://github.com/wkhtmltopdf/wkhtmltopdf.git /tmp/wkhtmltopdf

COPY conf/qt-musl.patch /tmp/wkhtmltopdf/qt/qt-musl.patch
COPY conf/qsettings-recursive-global-mutex.patch /tmp/wkhtmltopdf/qt/qsettings-recursive-global-mutex.patch



# remove qt build packages # 
RUN apk del --update \
	make g++ mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libxrender-dev alsa-lib-dev openssl-dev fontconfig-dev freetype-dev \
	glib-dev libpng-dev zlib-dev sqlite-dev dbus-dev postgresql-dev mariadb-dev unixodbc-dev cups-dev gtk+-dev tiff-dev libmng-dev \
	libxrandr-dev libxv-dev libxi-dev perl gawk paxmark rsync freetds-dev hicolor-icon-theme mesa-gl
RUN rm -rf /var/cache/apk/*