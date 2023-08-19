# OpenResty Docker Image with SPNEGO

This repository contains a Dockerfile for creating an OpenResty image that includes the SPNEGO authentication module.

## Features

- Based on `openresty/openresty`.
- Includes the SPNEGO authentication module for NGINX.
- Ready to use with default configuration.

## Build

To build the Docker image, run:

```bash
docker build -t my-openresty-spnego:latest .
```

## Run

To run a container using the built image:

```bash
docker run -d -p 80:80 -p 443:443 my-openresty-spnego:latest
```

## Configuration

The image uses the default OpenResty configuration. If you wish to use a custom configuration, mount your configuration file into the container at `/usr/local/openresty/nginx/conf/nginx.conf`.
