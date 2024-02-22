# 베이스 이미지로 Ubuntu 사용
FROM ubuntu:latest

# 작업 디렉토리 설정
WORKDIR /workspace

# 필요한 패키지 및 도구 설치
RUN apt-get update && apt-get install -y \
    crossbuild-essential-arm64 \
    make \
    cmake \
    git \
    wget \
    # OpenCV 의존성 추가
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
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
RUN git clone https://github.com/tensorflow/tensorflow.git tensorflow_src

# 컨테이너 실행 시 기본 명령
CMD ["/bin/bash"]
