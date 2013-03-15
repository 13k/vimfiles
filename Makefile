# prefix to install symlinks
SYMLINKS_PREFIX ?= $(HOME)
# dotfiles destinations, relative to $(PREFIX)
DOTFILES  = vimrc
DOTFILES += gvimrc

###

SYMLINKS = $(addprefix $(SYMLINKS_PREFIX)/., $(DOTFILES))

# where to store vim cache files
CACHE_PREFIX ?= $(HOME)/.cache/vim
# cache directories, relative to $(CACHE_PREFIX)
DIRECTORIES  = bundles
DIRECTORIES += swap
DIRECTORIES += backup
DIRECTORIES += undo

CACHE_TARGETS = $(addprefix $(CACHE_PREFIX)/, $(DIRECTORIES))

INSTALL_BUNDLES = cmd-t powerline

all: install

install: $(SYMLINKS) $(CACHE_TARGETS)

bundle: install
	ruby bundle

bundle-install: bundle $(INSTALL_BUNDLES)

$(SYMLINKS_PREFIX)/.%: %
	ln -s "$(abspath $<)" "$@"

$(CACHE_PREFIX)/%:
	mkdir -p "$@"

cmd-t: $(CACHE_PREFIX)/bundles/Command-T/ruby/command-t/extconf.rb
	[ -f ".ruby-version" -a ! -f "$(shell dirname $<)/.ruby-version" ] && cp .ruby-version "$(shell dirname $<)/.ruby-version" || true
	(cd "$(shell dirname $<)" && ruby extconf.rb && make)

powerline: $(CACHE_PREFIX)/bundles/powerline/setup.py
	(cd "$(shell dirname $<)" && python setup.py build && sudo python setup.py install)

.PHONY: all install
