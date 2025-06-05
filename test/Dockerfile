
# Run this docker image: docker build -f test/Dockerfile -t wsl .
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies needed for your script
RUN apt update && apt install -y \
    curl git zsh sudo locales build-essential wget unzip software-properties-common \
    && locale-gen pt_PT.UTF-8

# Create a non-root user for realism
RUN useradd -ms /bin/bash dev && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER dev
WORKDIR /home/dev

# Copy your install script into the container
COPY install.sh .
COPY .zshrc .


