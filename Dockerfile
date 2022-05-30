FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential vim tmux sudo &&\
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base as prime
ARG USERNAME=jtt
RUN addgroup --gid 1000 $USERNAME
RUN adduser --disabled-password --gecos '' --gid 1000 $USERNAME
RUN adduser $USERNAME sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
    /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME

#FROM prime
#WORKDIR /home/root
COPY . .
