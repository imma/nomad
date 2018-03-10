pkg := $(shell ls -thd results/*hart 2>/dev/null | head -1)

HAB_STUDIO_MODE := clone

studio:
	hab studio $(HAB_STUDIO_CLONE)

build:
	-hab studio $(HAB_STUDIO_CLONE) run build

upload:
	-hab studio $(HAB_STUDIO_CLONE) run hab pkg upload $(pkg)

export:
	-hab studio $(HAB_STUDIO_CLONE) run hab pkg export docker $(pkg)

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
