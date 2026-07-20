.PHONY: update watch list build build-all rebuild-lock check sync stats clean-cache clean-derived

update:
	python run_all.py

watch:
	python -m cuadernos watch

list:
	python -m cuadernos list

build:
	python -m cuadernos build

build-all:
	python -m cuadernos update --force

rebuild-lock:
	python -m cuadernos update --rebuild-lock

check:
	python -m cuadernos check --write

sync:
	python -m cuadernos update --no-build

stats:
	python -m cuadernos stats --write

clean-cache:
	rm -rf .cuadernos-cache
	rm -f tinymist.lock

clean-derived:
	rm -rf docs/assets/previews
	rm -f docs/catalog.json docs/bibliography.json docs/HEALTH.md docs/VALIDATION.md
	rm -f bibliografia/catalogo.bib
