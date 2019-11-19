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
