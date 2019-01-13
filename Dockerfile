ARG ARCH=arm32v7

FROM ${ARCH}/python:3.7-slim

RUN pip install pi-mqtt-gpio --no-cache-dir

ENTRYPOINT [ "python3", "-m", "pi_mqtt_gpio.server", "/srv/config.yml" ]
