FROM justincormack/docker-riscv

MAINTAINER Justin Cormack <justin@specialbusservice.com>

WORKDIR /usr/src/riscv-tools

ENV RISCV=/usr/local SYSROOT=/usr/local/sysroot TOP=/usr/src

# build Linux toolchain
RUN \
  mkdir -p $SYSROOT && mkdir $SYSROOT/usr && \
  cp -r $TOP/riscv-tools/riscv-gnu-toolchain/linux-headers/* $SYSROOT/usr && \
  cd $TOP/riscv-tools/riscv-gnu-toolchain && ./configure && make linux INSTALL_DIR=$RISCV SYSROOT=$SYSROOT

RUN \
  curl https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.29.tar.xz | tar -xJ && \
  cd linux-3.14.29 && \
  git init && \
  git remote add origin https://github.com/riscv/riscv-linux.git && \
  git fetch && \
  git checkout -f -t origin/master && \
  make ARCH=riscv defconfig && \
  make ARCH=riscv -j vmlinux
