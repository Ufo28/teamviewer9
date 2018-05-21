all: build

APP_NAME="teamviewer9"
IMG_NAME="teamviewer9"
TAG_NAME="latest"
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

ifndef APP_REPO
APP_REPO=${USER}
endif


ENV_VARS= \
    --env="APP_REPO=${APP_REPO}" \
    --env="APP_USER=${USER}" \
    --env="IMG_NAME=${IMG_NAME}" \
    --env="TAG_NAME=${TAG_NAME}" \
    --env="DISPLAY" \
    --env="XAUTHORITY=${XAUTH}"

VOLUMES= \
    --volume=${XSOCK}:${XSOCK} \
    --volume=${XAUTH}:${XAUTH} \

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build the ${APP_NAME} image"
	@echo "   2. make install          - install ${APP_NAME} wrappers"
	@echo "   3. make ${APP_NAME}      - launch ${APP_NAME}"
	@echo "   4. make bash             - bash login"
	@echo ""

clean:
	@rm -rf ${HOME}/.${APP_NAME}
	@docker rm -f `docker ps -a | grep "${APP_REPO}/${IMG_NAME}" | awk '{print $$1}'` > /dev/null 2>&1 || exit 0
	@docker rmi `docker images  | grep -e "${APP_REPO}/${IMG_NAME}.*${TAG_NAME}" | awk '{print $$3}'` > /dev/null 2>&1 || exit 0

build:
	@docker build --rm=true \
		--tag=${APP_REPO}/${IMG_NAME}:${TAG_NAME} .

instl uninstl: build
	@mkdir -p ${HOME}/.${APP_NAME}
	@docker run -it --rm \
		--volume=/usr/local/bin:/target \
		--volume=${HOME}/.${APP_NAME}:/opt/${APP_NAME}/config \
		${VOLUMES} \
		${ENV_VARS} \
		${APP_REPO}/${APP_NAME}:${TAG_NAME} $@

