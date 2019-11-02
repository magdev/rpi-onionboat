# rpi-onionboat
"A docker wrapper for [Tor](https://torproject.org) hidden services. It uses [docker-gen](https://github.com/jwilder/docker-gen) to configure Tor automatically when other containers are connected to the same network. The advantage of this approach is that it allows for optional network isolation and doesn't require building any containers yourself."

For more information please look at:
- https://nonconformity.net/2016/06/10/onionboat-using-docker-for-easy-tor-hidden-services/
- https://github.com/jheretic/onionboat

# what was modified?
Just a few changes in Dockerfile were made to provide Raspberry Pi support.
* Its now based on *schachr/raspbian-stretch:latest* instead of *sdhibit/rpi-raspbian:latest*
* The appropriate docker-gen for armhf, updated to version 0.7.4
* Optimized Dockerfile to use less layers
