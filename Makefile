.PHONY: pip_compile pip_install pip_update jupyter clean

ACTIVATE_VENV = source .venv/bin/activate
#
# GIT_NAMESPACE=git@gitlab.com:thomtimm
GIT_NAMESPACE=git@gitlab.codecentric.de:thomas.timmermann
GIT_REMOTE=$(GIT_NAMESPACE)/heise-nlp-20210331-notebooks.git

init:
	# git init && git stage . && git commit -m "cookiecutting"  &&
	git push --set-upstream $(GIT_REMOTE) master && \
	git remote add origin $(GIT_REMOTE)

clean:

install_venv:
	python3 -m venv .venv && $(ACTIVATE_VENV) && pip3 install --upgrade pip && pip3 install pip-tools

pip_install:
	$(ACTIVATE_VENV) && pip install -r requirements.txt


install: install_venv pip_install install_extensions

pip_compile:
	$(ACTIVATE_VENV) && pip-compile --verbose requirements.in > requirements.txt

pip_update: pip_compile pip_install

jupyter:
	$(ACTIVATE_VENV) && jupyter lab .


TAG = ml_essentials_2020_tensorflow2
PORT = 8888
RUNTIME=--runtime nvidia # leave empty for standard runtime

build_docker:
	docker build -t $(TAG) .

run_docker:
	docker run --mount "type=bind,src=`pwd`,dst=/notebooks" $(RUNTIME) --rm -it  -p $(PORT):8888  $(TAG)
