#
# Copyright 2015 Alien Laboratories, Inc.
#
# Base Dockerfile
#

#
# Base python image (includes tools).
#
FROM python:2.7

#
# Update everything.
#
RUN apt-get update
RUN apt-get -y upgrade

#
# Install nodejs and npm modules.
#
RUN apt-get install -y nodejs npm
RUN apt-get clean -y
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install jspm -g

#
# Install PIP modules (as root).
#
ADD requirements-base.txt /home/nx/app/requirements-base.txt
WORKDIR /home/nx/app
RUN pip install -r requirements-base.txt

#
# Create nx user.
# https://docs.docker.com/articles/dockerfile_best-practices/#user
# http://stackoverflow.com/questions/24308760/running-app-inside-docker-as-non-root-user
#
RUN groupadd -r nx && useradd -r -g nx nx
RUN chown -R nx:nx /home/nx

#
# Environment.
#
ENV HOME /home/nx
