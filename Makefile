# SPDX-License-Identifier: BSD-3-Clause
PREFIX=/usr
EPREFIX=
BINDIR=$(PREFIX)/bin
DATADIR=$(PREFIX)/share/push

.PHONY: FORCE all install uninstall clean distclean maintainer-clean

all: push.sh

push.sh:
	echo '#!$(EPREFIX)/bin/cat $(DATADIR)/push.sh' >push.sh

install: push.sh
	install -d '$(DESTDIR)$(BINDIR)'
	install -d '$(DESTDIR)/$(DATADIR)'
	install -m 755 push.sh '$(DESTDIR)$(BINDIR)/push.sh'
	install -m 644 bin/push.sh '$(DESTDIR)$(DATADIR)/push.sh'

uninstall: FORCE
	rm -f '$(DESTDIR)/$(BINDIR)/push.sh'
	rm -f '$(DESTDIR)/$(DATADIR)/push.sh'
	-rmdir '$(DESTDIR)/$(DATADIR)'

clean: FORCE
	rm -f ./push.sh

distclean: clean FORCE
	rm -f ./push-*.asc ./push-*.tar.* ./push-*.tar ./push-*.zip

maintainer-clean: distclean FORCE

FORCE:
