FROM solarkennedy/wine-x11-novnc-docker:latest

WORKDIR /root

ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y git curl unzip
