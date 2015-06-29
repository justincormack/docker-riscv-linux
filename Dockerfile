FROM justincormack/docker-riscv

MAINTAINER Justin Cormack <justin@specialbusservice.com>

WORKDIR /usr/src/riscv-tools

ENV RISCV=/usr/local SYSROOT=/usr/local/sysroot TOP=/usr/src

# build
RUN \
  mkdir -p $SYSROOT && mkdir $SYSROOT/usr && \
  cp -r $TOP/riscv-tools/riscv-gnu-toolchain/linux-headers/* $SYSROOT/usr && \
  cd $TOP/riscv-tools/riscv-gnu-toolchain && ./configure && make linux INSTALL_DIR=$RISCV SYSROOT=$SYSROOT
