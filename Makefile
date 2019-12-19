PREFIX:=/usr/local

.PHONY: install clean

all: qargs pad

qargs: qargs.c

pad: pad.c

clean:
	rm qargs
	rm pad

install: all
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
	install music-stream-mp3 $(PREFIX)/bin/
	install pad $(PREFIX)/bin/
	install music-listeners $(PREFIX)/bin/
