FROM python:3.8.1
EXPOSE 5000
LABEL maintainer "docker@gavinmogan.com"

WORKDIR /opt/octoprint

#install ffmpeg
RUN cd /tmp \
  && wget -O ffmpeg.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz \
	&& mkdir -p /opt/ffmpeg \
	&& tar xvf ffmpeg.tar.xz -C /opt/ffmpeg --strip-components=1 \
  && rm -Rf /tmp/*
RUN pip install virtualenv

#Create an octoprint user
RUN useradd -ms /bin/bash octoprint && adduser octoprint dialout
RUN chown octoprint:octoprint /opt/octoprint
USER octoprint
#This fixes issues with the volume command setting wrong permissions
RUN mkdir /home/octoprint/.octoprint
COPY requirements.txt requirements-plugins.txt ./

#Install Octoprint
RUN virtualenv venv \
  && ./venv/bin/pip install --upgrade setuptools \
	&& ./venv/bin/pip install -r requirements.txt \
	&& ./venv/bin/pip install -r requirements-plugins.txt

VOLUME /home/octoprint/.octoprint


CMD ["/opt/octoprint/venv/bin/octoprint", "serve"]

