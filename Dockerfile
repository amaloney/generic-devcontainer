FROM python:3.11-slim AS base

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y build-essential curl git sudo vim \
        python3-dev python3-pip python3-venv
ARG USER=vscode
ENV HOME=/home/$USER
RUN adduser --disabled-password --gecos "" $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

FROM base AS devcontainer

ARG REPONAME=
USER $USER
WORKDIR $HOME/$REPONAME
COPY . $HOME/$REPONAME
RUN python -m venv $HOME/venv
ENV PATH=$HOME/venv/bin:$PATH
RUN pip install --upgrade pip
