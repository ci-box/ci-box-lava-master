## Prerequisite

- docker
- docker-compose

## Build you container image

   [sudo] make

## Start image

   [sudo] make run

## Play

The configuration can be customized via docker-compose.yml file.
By default lava-server web interface is exposed to port 5580 (localhost:5580).
This is a lava-server only instance (not worker), it expects a worker0 dispatcher.
By default two qemu devices are automatically added via overlays.
