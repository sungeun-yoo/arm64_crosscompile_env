# 베이스 이미지로 Ubuntu 사용
From ubuntu:20.04

ARG DEBIAN_FRONTEND=noiteractive

ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

# 작업 디렉토리 설정
WORKDIR /workspace

# 필요한 패키지 및 도구 설치
# PPA 추가 및 패키지 목록 업데이트
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test

# GCC 11 설치
RUN apt-get update && apt-get install -y gcc-11 g++-11

# 기본 컴파일러로 GCC 11 설정
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-11

# ARM64 크로스 컴파일을 위한 필수 패키지 설치
RUN apt-get install -y crossbuild-essential-arm64


RUN apt-get update && apt-get install -y \
    make \
    cmake \
    git \
    wget \
    # OpenCV 의존성 추가
    #libjpeg-dev \
    #libpng-dev \
    #libtiff-dev \
    #libgtk2.0-dev \
    && rm -rf /var/lib/apt/lists/*

# OpenCV
RUN wget https://github.com/sungeun-yoo/opencv_install/releases/download/opencv409_aarch64_install/opencv409_aarch64_install.tar \
    && tar -xvf opencv409_aarch64_install.tar \
    && tar -xvf opencv409_aarch64_files.tar \
    && chmod +x install_opencv409_aarch64.sh \
    && ./install_opencv409_aarch64.sh \
    && rm -rf opencv409_aarch64_install.tar \
    && rm -rf opencv409_aarch64_files.tar \
    && rm -rf make_opencv409_aarch64.sh \
    && rm -rf install_opencv409_aarch64.sh

# Tensorflow
#RUN git clone https://github.com/tensorflow/tensorflow.git tensorflow_src

# Copy toolchain file
COPY ./linux_toolchain /workspace


# 컨테이너 실행 시 기본 명령
CMD ["/bin/bash"]

