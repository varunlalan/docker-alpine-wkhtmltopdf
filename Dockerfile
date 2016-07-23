FROM alpine:latest
MAINTAINER Trevor Ferre <trevor@alloylab.com>

# install qt build packages #
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --update \
	git patch gtk+ openssl glib fonts-base fonts-extra \
	make g++ glib-dev gtk+-dev mesa-dev openssl-dev
RUN rm -rf /var/cache/apk/*
	
# wkhtmltopdf #
RUN git clone --recursive https://github.com/wkhtmltopdf/wkhtmltopdf.git /tmp/wkhtmltopdf

COPY conf/qt-musl.patch /tmp/wkhtmltopdf/qt/qt-musl.patch
COPY conf/qt-musl-iconv-no-bom.patch /tmp/wkhtmltopdf/qt/qt-musl-iconv-no-bom.patch
COPY conf/qt-recursive-global-mutex.patch /tmp/wkhtmltopdf/qt/qt-recursive-global-mutex.patch
COPY conf/qt-font-pixel-size.patch /tmp/wkhtmltopdf/qt/qt-font-pixel-size.patch

RUN	cd /tmp/wkhtmltopdf/qt && \
	patch -p1 -i qt-musl.patch && \
	patch -p1 -i qt-musl-iconv-no-bom.patch && \
	patch -p1 -i qt-recursive-global-mutex.patch && \
	patch -p1 -i qt-font-pixel-size.patch && \
	sed -i "s|-O2|$CXXFLAGS|" mkspecs/common/g++.conf && \
	sed -i "/^QMAKE_RPATH/s| -Wl,-rpath,||g" mkspecs/common/g++.conf && \
	sed -i "/^QMAKE_LFLAGS\s/s|+=|+= $LDFLAGS|g" mkspecs/common/g++.conf && \
	./configure -confirm-license -opensource \
		-prefix /usr \
		-datadir /usr/share/qt \
		-sysconfdir /etc \
		-plugindir /usr/lib/qt/plugins \
		-importdir /usr/lib/qt/imports \
		-fast \
		-release \
		-static \
		-largefile \
		-glib \
		-graphicssystem raster \
		-qt-zlib \
		-qt-libpng \
		-qt-libmng \
		-qt-libtiff \
		-qt-libjpeg \
		-svg \
		-webkit \
		-gtkstyle \
		-xmlpatterns \
		-script \
		-scripttools \
		-openssl-linked \
		-nomake demos \
		-nomake docs \
		-nomake examples \
		-nomake tools \
		-nomake tests \
		-nomake translations \
		-no-qt3support \
		-no-pch \
		-no-icu \
		-no-phonon \
		-no-phonon-backend \
		-no-rpath \
		-no-separate-debug-info \
		-no-dbus \
		-no-opengl \
		-no-openvg && \
	make --silent && \
	make install && \
	cd /tmp/wkhtmltopdf && \
	qmake && \
	make --silent && \
	make install && \
	rm -rf /tmp/*

# remove qt build packages #
RUN apk del --update \
	make g++ glib-dev gtk+-dev mesa-dev openssl-dev
RUN rm -rf /var/cache/apk/*
