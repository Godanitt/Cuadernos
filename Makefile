.PHONY: update cuadernos papers watch list build build-all rebuild-lock check sync stats clean-cache clean-derived

update:
	python run_all.py

cuadernos:
	python run_all.py cuadernos

papers:
	python run_all.py paper

watch:
	python run_all.py watch

list:
	python run_all.py list

build:
	python run_all.py build

build-all:
	python run_all.py --force

rebuild-lock:
	python run_all.py --rebuild-lock

check:
	python run_all.py check --write

sync:
	python run_all.py sync

stats:
	python run_all.py stats --write

clean-cache:
	rm -rf .cuadernos-cache
	rm -f tinymist.lock

clean-derived:
	rm -rf pdf paper docs/assets/previews
	rm -f docs/catalog.json docs/HEALTH.md docs/VALIDATION.md
