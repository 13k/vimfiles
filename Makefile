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

$(CACHE_PREFIX)/%:
	mkdir -p "$@"

.PHONY: all install
