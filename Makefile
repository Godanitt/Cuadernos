.PHONY: update list build build-all check sync stats new-med clean-cache clean-generated

update:
	python -m cuadernos update

list:
	python -m cuadernos list

build:
	python -m cuadernos build

build-all:
	python -m cuadernos update --force

check:
	python -m cuadernos check --write

sync:
	python -m cuadernos update --no-build

stats:
	python -m cuadernos stats --write

new-med:
	python -m cuadernos new --area Medicina --title "Nuevo cuaderno de medicina"

clean-cache:
	rm -rf .cuadernos-cache

clean-generated:
	find cuadernos -type d -name generated -prune -exec rm -rf {} +
	rm -rf docs/assets/previews
	rm -f docs/catalog.json docs/bibliography.json docs/HEALTH.md docs/VALIDATION.md
