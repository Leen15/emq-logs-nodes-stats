#!/usr/bin/env ruby

require 'json'
require 'open-uri'

MQTT_USERNAME = ENV['MQTT_USERNAME'] || ''
MQTT_PASSWORD = ENV['MQTT_PASSWORD'] || ''
MQTT_SERVER = ENV['MQTT_SERVER'] || ''

# ----------------- GET NODES ------------------- #
json = open(MQTT_SERVER + "/api/v2/management/nodes",
           http_basic_authentication: [MQTT_USERNAME, MQTT_PASSWORD]).read
nodes_response = JSON.parse(json)

nodes_json = nodes_response['result']

nodes_list = []
clients_list = []
subscriptions_list = []
nodes_json.map do |node|

 # ----------------- GET CLIENTS FOR THIS NODE ------------------- #
 json = open(MQTT_SERVER + "/api/v2/nodes/%{node_name}/clients?page_size=100000" % {node_name: node['name']},
             http_basic_authentication: [MQTT_USERNAME, MQTT_PASSWORD]).read
 clients_response = JSON.parse(json)
 clients_json = clients_response['result']['objects']

 printf("name: \"%s\" uptime: \"%s\" version: \"%s\" node_status: \"%s\" clients_count: \"%s\"\n",
   node['name'],
   node['uptime'],
   node['version'],
   node['node_status'],
   clients_json.count)

end
