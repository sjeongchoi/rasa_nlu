OUTPUT_FILE=log.file
RASA_MITIE_CONFIG_JSON="./rosamia-txt/config_mitie_docker.json"
HOST_ROSAMIA_TXT_DIR="$PWD/rosamia-txt"
DOCKR_ROSAMIA_TXT_DIR="/app/rosamia-txt"


RASA_TRAIN_RUN_CMD="python -m rasa_nlu.train -c ${RASA_MITIE_CONFIG_JSON}"
RASA_DOCKER_SERVER_RUN_CMD="docker run  -i -p 5000:5000 -v ${HOST_ROSAMIA_TXT_DIR}:${DOCKR_ROSAMIA_TXT_DIR} rasa_nlu start -c ${RASA_MITIE_CONFIG_JSON} --server_model_dirs="

exec $RASA_TRAIN_RUN_CMD 2>&1 | tee ${OUTPUT_FILE}

HOST_MODEL_DIR=$(tail -2 ${OUTPUT_FILE} | head -2  | grep -Eo "'(.+?)'" |  sed "s/\'//g")
DOCKER_TRAIN_MODEL_NAME=$(basename $HOST_MODEL_DIR)

exec $RASA_DOCKER_SERVER_RUN_CMD$DOCKER_TRAIN_MODEL_NAME
#docker run -i -p 5000:5000 -v /Users/latte/Develop/workspace_rosamia/rasa_nlu/rosamia-txt:/app/rosamia-txt rasa_nlu start -c ./rosamia-txt/config_mitie_docker.json   --server_model_dirs=/app/rosamia-txt/models/model_20170720-141527

