FROM julia:latest

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

RUN apt update
RUN apt-get -y install wget
RUN apt-get -y install git g++ cmake qt5-default python-docutils

#RUN apt-get -y install build-essential libgl1-mesa-dev
#RUN apt-get -y install libdbus-glib-1-2
#RUN apt-get -y install dbus-x11
#RUN apt-get -y install libglib2.0-tests
#RUN apt-get -y install libgee-0.8-2
#RUN apt-get -y install libmoonshot1

WORKDIR /usr/local
RUN git clone https://github.com/c42f/displaz.git
WORKDIR /usr/local/displaz/build_external
RUN cmake ../thirdparty/external && make -j4

WORKDIR /usr/local/displaz/build
RUN cmake .. && make -j4

ENV PATH "/usr/local/displaz/build/bin/:${PATH}"

WORKDIR /playpen

USER appuser
CMD /bin/bash
