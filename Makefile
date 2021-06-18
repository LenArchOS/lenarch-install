OUTDIR ?= build

CALAMARES_OUT := $(wildcard $(OUTDIR)/calamares-*.pkg.tar.zst)
CALAMARES_CONFIG_OUT := $(wildcard $(OUTDIR)/calamares-config*.pkg.tar.zst)

.PHONY:all
all:CALAMARES_OUT CALAMARES_CONFIG_OUT

.PHONY:calamares
calamares:CALAMARES_OUT CALAMARES_CONFIG_OUT

CALAMARES_OUT:calamares/*
	mkdir -p $(OUTDIR)
	(cd calamares && sh install_dependencies.sh && makepkg -fs)
	mv calamares/*.pkg.tar.zst $(OUTDIR)/

CALAMARES_CONFIG_OUT:lenarch-calamares-config/*
		mkdir -p $(OUTDIR)
	(cd lenarch-calamares-config && makepkg -fs)
	mv lenarch-calamares-config/*.pkg.tar.zst $(OUTDIR)/


.PHONY:clean
clean:
	rm -rf build/
	rm -rf */pkg/
	rm -rf calamares/src/
	rm -rf calamares/calamares-*