FROM lsiobase/ubuntu:focal
LABEL maintainer="RandomNinjaAtk"

ENV TITLE="Automated Music Archiver (AMA)"
ENV TITLESHORT="AMA"
ENV VERSION="1.0.94"
ENV XDG_CONFIG_HOME="/config/deemix/xdg"
RUN \
	echo "************ install dependencies ************" && \
	echo "************ install and upgrade packages ************" && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		netbase \
		jq \
		flac \
		eyed3 \
		python3 \
                git \
		nano \
                wget \
		ffmpeg \
		opus-tools \
		python3-pip && \
	rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/* && \
        gpg --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys F23C5A6CF475977595C89F51BA6932366A755776
        gpg --export  F23C5A6CF475977595C89F51BA6932366A755776 | tee /usr/share/keyrings/deadsnakes.pgp
        echo 'deb [signed-by=/usr/share/keyrings/deadsnakes.pgp] https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu focal main' | tee /etc/apt/sources.list.d/deadsnakes.list
	apt-get update
        apt-get install python3.11 python3.11-distutils
	
	echo "************ install python packages ************" && \
	python3 -m pip install --no-cache-dir -U \
		yq \
		mutagen \
		r128gain \
		deemix && \
	echo "************ setup dl client config directory ************" && \
	echo "************ make directory ************" && \
	mkdir -p "${XDG_CONFIG_HOME}/deemix"
        apt-get install python3.11 python3.11-distutils
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
	pip3 install git+https://github.com/nathom/streamrip.git@dev
# copy local files
COPY root/ /
 
# set work directory
WORKDIR /config
