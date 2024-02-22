# arm64_crosscompile_env
arm64_crosscompile_env docker 환경

OpenCV4.x, tensorflow-lite 기본설치해서 프로젝트를 빌드하기 위한 기본 구성을 가지고 있음

## OpenCV4 install
### 1. 직접 빌드하는 방법
```
git clone https://github.com/opencv/opencv.git
cd opencv &&  mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/aarch64-gnu.toolchain.cmake -D CMAKE_CXX_STANDARD=11 ../ && make -j24 && make install
```
### 2. 4.9 버전 빌든된것 설치 (dockerfile 에 포함되어있음)
이 방법은 aarch64 보드에 직접 설치할때 유용함.
```
wget https://github.com/sungeun-yoo/opencv_install/releases/download/opencv409_aarch64_install/opencv409_aarch64_install.tar \
    && tar -xvf opencv409_aarch64_install.tar \
    && tar -xvf opencv409_aarch64_files.tar \
    && chmod +x install_opencv409_aarch64.sh \
    && ./install_opencv409_aarch64.sh \
    && rm -rf opencv409_aarch64_install.tar \
    && rm -rf opencv409_aarch64_files.tar \
    && rm -rf make_opencv409_aarch64.sh \
    && rm -rf install_opencv409_aarch64.sh
```

---
## Minimal test build
```
mkdir minimal_build
cd minimal_build
cmake -D CMAKE_TOOLCHAIN_FILE=/workspace/linux_toolchain/aarch64-toolchain.cmake /workspace/tensorflow_src/tensorflow/lite/examples/minimal/
make -j8
```


