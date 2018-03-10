pkg := $(shell ls -thd results/*hart | head -1)

studio:
	hab studio clone

build:
	-hab studio clone run build

upload:
	-hab studio clone run hab pkg upload $(pkg)

export:
	-hab studio clone run hab pkg export docker $(pkg)

up:
	$(MAKE) down
	docker-compose build
	docker-compose up $(compose)

down:
	docker-compose down

quickly:
	$(MAKE) build 
	$(MAKE) quickly_

quickly_:
	$(MAKE) export up pkg=$(shell ls -thd results/*hart | head -1) 
