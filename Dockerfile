ARG ARCH=arm32v7/

FROM ${ARCH}python:3.7-slim as builder

COPY requirements.txt /build/requirements.txt

RUN apt-get update

RUN apt-get install gcc -y

RUN pip install -r /build/requirements.txt

FROM ${ARCH}python:3.7-slim

COPY --from=builder /root/.cache /root/.cache
COPY --from=builder /build/requirements.txt /build/requirements.txt
RUN pip install -r /build/requirements.txt && rm -rf /root/.cache /build/requirements.txt

ENTRYPOINT [ "python3", "-m", "pi_mqtt_gpio.server", "/srv/config.yml" ]
