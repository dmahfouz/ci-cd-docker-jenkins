FROM jenkins/jenkins:lts-alpine
USER root
# Install Python3 here 
RUN apk add --no-cache python3 && \
 python3 -m ensurepip && \
 pip3 install --upgrade pip setuptools && \
 if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
 if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
 rm -r /root/.cache
RUN apk add pkgconf
RUN apk add build-base
RUN apk add python3-dev

RUN mkdir /my_app
WORKDIR /my_app
COPY requirements.txt /my_app
RUN pwd
RUN ls -la

# # Install tools required for compiling Python 3.6.5 and 
# # wget for install pip3
# RUN apt-get update  -y && \
#         apt-get upgrade -y

# RUN apt-get install -y \
#         build-essential \
#         libssl-dev \
#         zlib1g-dev \
#         libncurses5-dev \
#         libreadline-dev \
#         libsqlite3-dev \
#         libgdbm-dev \
#         libdb5.3-dev \
#         libbz2-dev \
#         libexpat1-dev \
#         liblzma-dev \
#         tk-dev \
#         wget

# # Copy sh script responsible for installing Python
# COPY config/installpython3.sh ./root/tmp/installpython3.sh

# # Run the script responsible for installing Python 3.6.5
# # and link it to /usr/bin/python3
# RUN chmod +x /root/tmp/installpython3.sh; sync && \
# 	./root/tmp/installpython3.sh && \
# 	rm -rf /root/tmp/installpython3.sh && \
#     ln -snf python2.7 /usr/bin/python && \
#     echo '**********PYTHON DIRECTORY LIST HERE*************' && \
#     ls -al Python-3.6.5/ && \
# 	ln -s /Python-3.6.5/python /usr/bin/python3

# # Install pip3 for Python 3.6.1
# RUN rm -rf /usr/local/lib/python3.6/site-packages/pip* && \
# 	wget https://bootstrap.pypa.io/get-pip.py && \
#     python -V && \
# 	python3 get-pip.py && \
# 	rm get-pip.py
