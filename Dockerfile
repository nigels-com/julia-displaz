FROM julia:latest

#RUN groupadd -g 999 appuser && useradd -r -u 999 -g appuser appuser

RUN apt update
RUN apt-get -y install wget
RUN apt-get -y install git g++ cmake qt5-default python-docutils

# Dependencies for glvnd and X11. (https://medium.com/@benjamin.botto/opengl-and-cuda-applications-in-docker-af0eece000f1)
RUN apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
  && rm -rf /var/lib/apt/lists/*
# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# to allow testing of opengl
#RUN apt-get install -y -qq glmark2

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

#USER appuser
CMD /bin/bash
