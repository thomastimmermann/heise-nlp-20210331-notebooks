.PHONY: pip_compile pip_install pip_update jupyter clean

ACTIVATE_VENV = source .venv/bin/activate

clean:


pip_compile:
	$(ACTIVATE_VENV) && pip-compile requirements.in > requirements.txt

pip_install:
	$(ACTIVATE_VENV) && pip install -r requirements.txt

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
