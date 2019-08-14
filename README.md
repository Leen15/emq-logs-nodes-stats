# emq-logs-nodes-stats

 This script uses EMQ APIs to detect current status of cluster nodes and print them in console.

## How to use it

 Simple run it as a docker container:
 ```
 docker run -it \
-e MQTT_USERNAME=admin \
-e MQTT_PASSWORD=password \
-e MQTT_SERVER=http://mqtt.your.domain:18083 \
 leen15/emq-logs-nodes-stats
```

And you will receive a list of nodes with useful info:
```
name: "emq@10.42.114.47" uptime: "96 days,14 hours, 53 minutes, 35 seconds" version: "2.3.11" node_status: "Running" clients_count: "125"
name: "emq@10.42.40.204" uptime: "48 days,11 hours, 51 minutes, 20 seconds" version: "2.3.11" node_status: "Running" clients_count: "143"
name: "emq@10.42.186.84" uptime: "47 days,10 hours, 33 minutes, 50 seconds" version: "2.3.11" node_status: "Running" clients_count: "138"
```

This container returns nodes data and then stop itself.
We use it with Kubernetes Cron Jobs, so we can monitoring nodes status and create useful dashboards.
