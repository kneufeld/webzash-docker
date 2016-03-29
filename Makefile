
NAME = webzash
LISTEN_SOCKET = 8030
PORT = -p $(LISTEN_SOCKET):$(LISTEN_SOCKET) --net=host

CONFIG = -v /etc/webzash/uwsgi.ini:/opt/config/uwsgi.ini
DATA = -v /etc/webzash/webzash.sqlite:/opt/webzash/app/Plugin/Webzash/Database/webzash.sqlite

IMAGE = webzash
DETACH ?= -d

cmd:
	docker run $(DETACH) --name $(NAME) $(PORT) $(CONFIG) $(DATA) $(IMAGE)

bash:
	docker run --rm -ti --name $(NAME) $(PORT) $(CONFIG) $(DATA) $(IMAGE) /bin/bash

test:
	docker run --rm --name $(NAME) $(PORT) $(CONFIG) $(DATA) $(IMAGE)

start:
	docker start $(NAME)

stop:
	docker stop $(NAME)

rm:
	$(MAKE) stop
	docker rm $(NAME)

rm-all:
	@echo removing all dead instances
	docker rm $(docker ps -q -f status=exited)

build:
	(cd ..; docker build -t $(NAME) $(NAME) )
