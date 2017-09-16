FROM pathtrk/docker-python3-opencv:contrib

LABEL maintener="Ryosuke Goto <ryosuke.goto@gmail.com>"

RUN apt-get update && \	
    apt-get install -y \
      build-essential \
      python-dev \
      locales \
      libblas-dev \
      liblapack-dev \
      libatlas-base-dev \
      autotools-dev \
      libicu-dev \
      libbz2-dev \
      gfortran

RUN rm -rf /var/lib/apt/lists/*

# install cmake
RUN apt-get remove -y cmake
RUN wget https://cmake.org/files/v3.9/cmake-3.9.2-Linux-x86_64.sh
RUN sh cmake-3.9.2-Linux-x86_64.sh --skip-license

# install boost with -fPIC
RUN wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.gz
RUN tar xvzf boost_1_64_0.tar.gz
WORKDIR boost_1_64_0/
RUN ln -s /usr/local/include/python3.5m /usr/local/include/python3.5
RUN echo "using python : 3.5 ;" >> /etc/site-config.jam
RUN ./bootstrap.sh --prefix=/usr/local
RUN ./b2 -j $(nproc) --with-python stage
RUN ./b2 -j $(nproc) cxxflags=-fPIC install
RUN echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf
RUN ldconfig

# set the locale to en_US.UTF-8 to perform migrations successfully
ENV DEBIAN_FRONTEND noninteractive
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# clean up
WORKDIR /
RUN rm cmake-3.9.2-Linux-x86_64.sh
RUN rm -rf /boost_1_64_0**
RUN rm -rf /var/lib/apt/lists/*