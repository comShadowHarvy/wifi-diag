PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin

.PHONY: all test install uninstall

all: test

test:
	@echo "Checking syntax of wifi-diag and wifi-diag.sh..."
	python3 -m py_compile wifi-diag
	bash -n wifi-diag.sh
	@echo "Testing wifi-diag execution..."
	./wifi-diag --version
	./wifi-diag --no-ping -1
	@echo "All tests passed successfully!"

install:
	@mkdir -p $(BINDIR)
	install -m 755 wifi-diag $(BINDIR)/wifi-diag
	install -m 755 wifi-diag.sh $(BINDIR)/wifi-diag.sh
	ln -sf $(BINDIR)/wifi-diag $(BINDIR)/wifi-info
	@echo "Installed wifi-diag, wifi-diag.sh, and wifi-info to $(BINDIR)"
	@echo "Ensure $(BINDIR) is in your PATH."

uninstall:
	rm -f $(BINDIR)/wifi-diag $(BINDIR)/wifi-diag.sh $(BINDIR)/wifi-info
	@echo "Uninstalled wifi-diag from $(BINDIR)"
