# 베이스 이미지로 Ubuntu 사용
FROM ubuntu:latest

# 필요한 패키지 및 도구 설치
RUN apt-get update && apt-get install -y \
    crossbuild-essential-arm64 \
    make \
    cmake \
    git \
    # OpenCV 의존성 추가
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
    && rm -rf /var/lib/apt/lists/*

# OpenCV 소스 코드 다운로드
RUN git clone https://github.com/opencv/opencv.git /opencv
# 원하는 OpenCV 버전으로 체크아웃 (예: 4.5.1)
RUN cd /opencv && git checkout 4.5.1

# OpenCV 빌드 및 설치
#RUN mkdir /opencv/build && cd /opencv/build && \
#    cmake -D CMAKE_BUILD_TYPE=RELEASE \
#          -D CMAKE_INSTALL_PREFIX=/usr/local \
#          -D CMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/aarch64-gnu.toolchain.cmake \
#          -D CMAKE_CXX_STANDARD=11 \
#          ../ && \
#    make -j16 && make install

# 작업 디렉토리 설정
WORKDIR /workspace

# 컨테이너 실행 시 기본 명령
CMD ["/bin/bash"]
