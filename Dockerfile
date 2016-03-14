FROM alpine:latest
MAINTAINER Trevor Ferre <trevor@alloylab.com>

# set lang so wkhtmltopdf help is in correct lang #
ENV LANG en_US.UTF-8

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

RUN	cd /tmp/wkhtmltopdf/qt && \
	patch -p1 -i qt-musl.patch && \
	patch -p1 -i qsettings-recursive-global-mutex.patch && \
	./configure -confirm-license -opensource \
		-nomake tools,examples,demos,docs,translations \
		-prefix /usr \
		-plugindir /usr/lib/qt/plugins \
		-importdir /usr/lib/qt/imports \
		-datadir /usr/share/qt \
		-sysconfdir /etc && \
	make && \
	make install && \
	cd /tmp/wkhtmltopdf && \
	qmake && \
	make && \
	make install && \
	cd / && rm -rf /tmp/*