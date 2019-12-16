PREFIX:=/usr/local

.PHONY: install

qargs: qargs.c

install: qargs
	install qargs $(PREFIX)/bin/
	install music-player $(PREFIX)/bin/
	install music-playpause $(PREFIX)/bin/
	install music-init $(PREFIX)/bin/
	install music-pause $(PREFIX)/bin/
	install music-unpause $(PREFIX)/bin/
	install music-stop $(PREFIX)/bin/
	install music-prev $(PREFIX)/bin/
	install music-next $(PREFIX)/bin/
	install music-nowplaying $(PREFIX)/bin/
	install music-fileinfo $(PREFIX)/bin/
	install music-playdir $(PREFIX)/bin/
	install music-playlist $(PREFIX)/bin/
	install music-setnowplaying $(PREFIX)/bin/
	install music-rebroadcast $(PREFIX)/bin/
	install icy-metadata $(PREFIX)/bin/
	install music-radio $(PREFIX)/bin/
	install music-stream $(PREFIX)/bin/
