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

ifeq (from,$(firstword $(MAKECMDGOALS)))
FROM_ := $(strip $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))
$(eval $(FROM_):;@:)
endif
ifeq (,$(FROM_))
FROM_ = 172.17.40.1
endif

from:
	rsync -ia ../$(FROM_)/habitat .
	rsync -ia ../$(FROM_)/Makefile .
	rsync -ia ../$(FROM_)/docker-compose.yml .
	rsync -ia ../$(FROM_)/.gitignore .
	rsync -ia ../$(FROM_)/.env .
