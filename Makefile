CONTAINER_NAME=k8s_presentation


build:
	docker build -f "Dockerfile" -t ${CONTAINER_NAME} .

exec:
	docker run --rm \
	-p 8888:8888 -p 8000:8000 \
	--entrypoint /bin/bash \
	--mount type=bind,source=$(shell pwd),target=/root \
	-v ${HOME}/.kube:/root/.kube \
	-v ${HOME}/.config:/root/.config  \
	--name ${CONTAINER_NAME} -it ${CONTAINER_NAME}

attach:
	docker exec -it k8s_presentation /bin/bash


watch:
	watch -n 5 docker container ls


# Juptyer Commamadns
# - notebook: start notebook server
# - slides: ipynb presenation to slides.

notebook:
	jupyter notebook --ip=0.0.0.0 --allow-root


slides:
	jupyter nbconvert presentation.ipynb --to slides --post serve --ip=0.0.0.0
	

# Kubernetes Commamadn
