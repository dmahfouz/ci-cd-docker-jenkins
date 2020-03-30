FROM jenkins:latest
USER root
RUN mkdir /my_app
WORKDIR /my_app
COPY requirements.txt /mp_app
RUN pwd
RUN ls -la
RUN apt-get update
RUN apt-get install -y python-pip
