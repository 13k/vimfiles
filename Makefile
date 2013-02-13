# where to store vim cache files
CACHE_PREFIX ?= $(HOME)/.cache/vim
# cache directories, relative to $(CACHE_PREFIX)
DIRECTORIES  = bundles
DIRECTORIES += swap
DIRECTORIES += backup
DIRECTORIES += undo

###

CACHE_TARGETS = $(addprefix $(CACHE_PREFIX)/, $(DIRECTORIES))

all: install

install: $(CACHE_TARGETS)

bundle: install
	ruby bundle

cmd-t: $(CACHE_PREFIX)/bundles/Command-T/ruby/command-t/extconf.rb
	[ -f ".ruby-version" -a ! -f "$(shell dirname $<)/.ruby-version" ] && cp .ruby-version "$(shell dirname $<)/.ruby-version"
	(cd "$(shell dirname $<)" && ruby extconf.rb && make)

cext: bundle cmd-t

$(CACHE_PREFIX)/%:
	mkdir -p "$@"

.PHONY: all install
