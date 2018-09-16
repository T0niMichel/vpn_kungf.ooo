# VPN Kungf.ooo


This Dockerfile provides an image that is used by vpn.kungf.ooo. 
Basicly it runs a tinc server. 

see > [tinc](http://www.tinc-vpn.org) 

## Usage

The default entrypoint of the container is tinc, so you can directly issue commands to tinc, 
for example `docker run tonimichel/vpn_kungf.ooo init` (which will run `tinc init` inside the container) 
to have tinc create the basic configuration for you. 

Tinc's configuration is persisted as a volume, 
you can also share a host folder in `/etc/tinc`.

tinc requires access to `/dev/net/tun`. Allow the container access to the device and grant the `NET_ADMIN` capability:

    --device=/dev/net/tun --cap-add NET_ADMIN

To make the VPN available to the host, 
and not only (linked) containers, use `--net=host`.

A reasonable basic run command loading persisted configuration from `/srv/tinc` and creating the VPN on the host network would be

    docker run -d \
        --name tinc \
        --net=host \
        --device=/dev/net/tun \
        --cap-add NET_ADMIN \
        --volume /srv/tinc:/etc/tinc \
        tonimichel/vpn_kungf.ooo start -D

Everything following `start` are parameters to `tincd`, `-D` makes sure the daemon stays active and does not actually daemonize, 
which would terminate the container.



## Administration and Maintenance

[tinc documentation](http://www.tinc-vpn.org/documentation-1.1/)

docker run -it --rm --name tinc tonimichel/vpn_kungf.ooo --help

To enter the container for various reasons, 
use `docker exec`, for example as `docker exec -ti [container-name] /bin/bash`.