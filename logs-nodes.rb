#!/usr/bin/env ruby
require 'json'
require 'open-uri'

MQTT_USERNAME     = ENV['MQTT_USERNAME'] || ''
MQTT_PASSWORD     = ENV['MQTT_PASSWORD'] || ''
MQTT_SERVER       = ENV['MQTT_SERVER'] || ''
MQTT_API_VERSION  = ENV['MQTT_API_VERSION'] || 'v2'

if MQTT_API_VERSION == 'v2'
  # get nodes
  json = open(
    "#{MQTT_SERVER}/api/v2/management/nodes",
    http_basic_authentication: [MQTT_USERNAME, MQTT_PASSWORD]
  ).read

  JSON.parse(json)['result'].map do |node|
    # get clients for this node
    json = open(
      "#{MQTT_SERVER}/api/v2/nodes/#{node['name']}/clients?page_size=100000",
      http_basic_authentication: [MQTT_USERNAME, MQTT_PASSWORD]
    ).read
    clients_json = JSON.parse(json)['result']['objects']

    printf(
      "name=\"%s\" uptime=\"%s\" version=\"%s\" node_status=\"%s\" clients_count=\"%s\"\n",
      node['name'],
      node['uptime'],
      node['version'],
      node['node_status'],
      clients_json.count
    )
  end
elsif MQTT_API_VERSION == 'v3'
  # get nodes
  json = open(
    "#{MQTT_SERVER}/api/v3/nodes",
    http_basic_authentication: [MQTT_USERNAME, MQTT_PASSWORD]
  ).read

  JSON.parse(json)['data'].map do |node|
    printf(
      "name=\"%s\" uptime=\"%s\" version=\"%s\" node_status=\"%s\" clients_count=\"%s\"\n",
      node['name'],
      node['uptime'],
      node['version'],
      node['node_status'],
      node['connections']
    )
  end
else
   puts "MQTT_API_VERSION unsupported."
end
