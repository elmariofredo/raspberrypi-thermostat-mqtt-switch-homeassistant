# raspberrypi thermostat mqtt switch homeassistant

 Raspberry PI Docker Image managing relay using MMQT for Home Assistant Generic Thermostat


## 1. On raspberry pi 3 start docker image 

Create config file

```yaml
mqtt:
  host: 192.168.0.221
  port: 1883
  user: ""
  password: ""
  topic_prefix: boiler_room
  status_topic: status
  status_payload_running: "online" 
  status_payload_stopped: "offline" 
  status_payload_dead: "dead"

gpio_modules:
  - name: raspberrypi
    module: raspberrypi

digital_outputs:
  - name: thermostat
    module: raspberrypi
    pin: 26
    on_payload: "on"
    off_payload: "off"
    initial: low  # This optional value controls the initial state of the pin before receipt of any messages from MQTT. Valid options are 'low' and 'high'.
    retain: no # This option value controls if the message is retained. Default is no.
```

Start docker container

$ `docker run --privileged -it --rm -v /srv/config.yml:/srv/config.yml -v /dev/gpiochip0:/dev/gpiochip0 elmariofredo/raspberrypi-thermostat-mqtt-switch-homeassistant:arm32v7-0.1`

## 2. Add switch config to homeassistant `configuration.yaml` file

```yaml
switch:
  - platform: mqtt
    name: thermostat
    state_topic: "boiler_room/output/thermostat"
    availability_topic: "boiler_room/status"
    command_topic: "boiler_room/output/thermostat/set"
    payload_on: "on"
    payload_off: "off"
```
