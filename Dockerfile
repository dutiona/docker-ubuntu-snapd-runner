FROM ubuntu:xenial
LABEL maintainer="Michaël Roynard <mroynard@lrde.epita.fr>"

ENV container docker
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH /snap/bin:$PATH

# Install all pkg
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && apt-get dist-upgrade -y && apt-get upgrade -y
RUN apt-get install -y \
    build-essential binutils git fuse squashfuse snapcraft snapd snap-confine python python-pip python3 python3-pip
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get autoclean -y && rm -rf /var/lib/apt/lists/
RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm

# Install python packages
RUN echo y | pip install -U pip six wheel setuptools
RUN echo y | pip3 install -U pip six wheel setuptools

RUN systemctl enable snapd

WORKDIR /workspace

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
