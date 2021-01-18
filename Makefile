PREFIX:=/usr/local

.PHONY: install clean

all: qargs pad icy-metadata

qargs: qargs.c

pad: pad.c

clean:
	rm qargs
	rm pad

icy-metadata: icy-metadata.c

install: all
	install id3sort	$(PREFIX)/bin/
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
	install music-getplaying $(PREFIX)/bin/
	install music-setnowplaying-xwintitle $(PREFIX)/bin/
	install youtube $(PREFIX)/bin/
	install music-search $(PREFIX)/bin/
	install music-albumart $(PREFIX)/bin/
	install music-record $(PREFIX)/bin/
	install music-push $(PREFIX)/bin/
	install music-pushmeta $(PREFIX)/bin/
	install music-updateplaying $(PREFIX)/bin/
	install -t $(PREFIX)/bin/ music-pop
