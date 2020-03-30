# Setting up continuous integration with Jenkins for a Python 3 Flask application with Docker

## Disclaimer
This repo has mostly been adapted from the following Medium article: [Basic CI/CD for Python projects with Docker and Jenkins](https://medium.com/faun/basic-ci-cd-for-python-projects-with-docker-and-jenkins-38eeb547fb28) and fixed using the work-around posted in the Medium article: [Jenkins+Python 3.6 Alpine Docker Image](https://medium.com/@mirsaeedi/jenkins-python-3-6-alpine-docker-image-8c22bd025533).

The purpose for this repo is a reference/guide to the steps I took when following the article to in getting a successful build on Jenkins with Python 3.

## Part 0 - Set up Docker

- Follow instructions for downloading Docker on your OS of choice - https://www.docker.com/get-started
- Check Docker is working in the terminal by running
    - `docker -version`


## Part 1 - Build a customised docker image of Jenkins with `Dockerfile`

- Create a folder with a name of your choice, I chose to create a folder called `./ci-cd-docker-jenkins/`, and added a Dockerfile with the following contents:

> `Dockerfile`
> ```docker
>FROM jenkins/jenkins:lts-alpine
>USER root
>
># Install Python3 here 
>RUN apk add --no-cache python3 && \
>       python3 -m ensurepip && \
>       pip3 install --upgrade pip setuptools && \
>       if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
>       if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
>       rm -r /root/.cache
>
>RUN apk add pkgconf
>RUN apk add build-base
>RUN apk add python3-dev
>
>RUN mkdir /my_app
>WORKDIR /my_app
>COPY requirements.txt /my_app
>RUN pwd
>RUN ls -la```


- Build docker image using the following command:
    > `docker build -t “jenkins:test” path/to/repo`


## Jenkins build
In Jenkins build -> execute shell textbox command, enter:

```sh
echo 'Start installing dependencies'

#!/bin/bash
pip install -r /my_app/requirements.txt

echo 'Start running test cases'
python -m unittest -v tests/test_hello_world
```