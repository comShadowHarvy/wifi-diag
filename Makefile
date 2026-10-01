PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share

.PHONY: all test install uninstall

all: test

test:
	@echo "Checking syntax of wifi-diag and wifi-diag.sh..."
	python3 -m py_compile wifi-diag
	bash -n wifi-diag.sh
	@echo "Testing wifi-diag execution..."
	./wifi-diag --version
	./wifi-diag --no-ping -1
	./wifi-diag -c
	./wifi-diag -m
	@echo "All tests passed successfully!"

install:
	@mkdir -p $(BINDIR)
	install -m 755 wifi-diag $(BINDIR)/wifi-diag
	install -m 755 wifi-diag.sh $(BINDIR)/wifi-diag.sh
	ln -sf $(BINDIR)/wifi-diag $(BINDIR)/wifi-info
	@# Bash completions
	@mkdir -p $(DATADIR)/bash-completion/completions
	install -m 644 completions/wifi-diag.bash $(DATADIR)/bash-completion/completions/wifi-diag
	ln -sf $(DATADIR)/bash-completion/completions/wifi-diag $(DATADIR)/bash-completion/completions/wifi-info
	@# Fish completions
	@mkdir -p $(DATADIR)/fish/vendor_completions.d
	install -m 644 completions/wifi-diag.fish $(DATADIR)/fish/vendor_completions.d/wifi-diag.fish
	@# Zsh completions
	@mkdir -p $(DATADIR)/zsh/site-functions
	install -m 644 completions/wifi-diag.zsh $(DATADIR)/zsh/site-functions/_wifi-diag
	@echo "Installed wifi-diag, wifi-diag.sh, and wifi-info to $(BINDIR)"
	@echo "Installed shell completions to $(DATADIR)"
	@echo "Ensure $(BINDIR) is in your PATH."

uninstall:
	rm -f $(BINDIR)/wifi-diag $(BINDIR)/wifi-diag.sh $(BINDIR)/wifi-info
	rm -f $(DATADIR)/bash-completion/completions/wifi-diag $(DATADIR)/bash-completion/completions/wifi-info
	rm -f $(DATADIR)/fish/vendor_completions.d/wifi-diag.fish
	rm -f $(DATADIR)/zsh/site-functions/_wifi-diag
	@echo "Uninstalled wifi-diag from $(BINDIR) and $(DATADIR)"
