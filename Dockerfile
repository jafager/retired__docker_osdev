FROM centos:7
RUN yum -y -q update


RUN mkdir /root/build
WORKDIR /root/build


RUN yum -y -q install gcc make file
COPY binutils-2.29.tar.gz .
RUN tar xfz binutils-2.29.tar.gz
RUN mkdir binutils-build
WORKDIR binutils-build
RUN ../binutils-2.29/configure --prefix=/usr/local --target=x86_64-elf
RUN make
RUN make install
WORKDIR ..
RUN rm -fr binutils-2.29.tar.gz binutils-2.29 binutils-build


RUN yum -y -q install gmp-devel mpfr-devel libmpc-devel gcc-c++
COPY gcc-7.2.0.tar.gz .
RUN tar xfz gcc-7.2.0.tar.gz
RUN mkdir gcc-build
WORKDIR gcc-build
RUN ../gcc-7.2.0/configure --prefix=/usr/local --target=x86_64-elf --enable-languages=c --without-headers
RUN make all-gcc
RUN make all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc
WORKDIR ..
RUN rm -fr gcc-7.2.0.tar.gz gcc-7.2.0 gcc-build


RUN yum -y -q install zlib-devel automake autoconf libtool glib2-devel
COPY qemu-2.9.0.tar.xz .
RUN xz -dc qemu-2.9.0.tar.xz | tar xvf -
WORKDIR qemu-2.9.0
RUN ./configure --prefix=/usr/local --target-list=x86_64-softmmu
RUN make
RUN make install
WORKDIR ..
RUN rm -fr qemu-2.9.0.tar.xz qemu-2.9.0


COPY nasm-2.13.01.tar.gz .
RUN tar xfz nasm-2.13.01.tar.gz
WORKDIR nasm-2.13.01
RUN ./configure --prefix=/usr/local
RUN make
RUN make install
WORKDIR ..
RUN rm -fr nasm-2.13.01.tar.gz nasm-2.13.01


COPY xorriso-1.4.6.tar.gz .
RUN tar xfz xorriso-1.4.6.tar.gz
WORKDIR xorriso-1.4.6
RUN ./configure --prefix=/usr/local
RUN make
RUN make install
WORKDIR ..
RUN rm -fr xorriso-1.4.6.tar.gz xorriso-1.4.6


COPY cmake-3.9.1.tar.gz .
RUN tar xfz cmake-3.9.1.tar.gz
WORKDIR cmake-3.9.1
RUN ./configure --prefix=/usr/local
RUN make
RUN make install
WORKDIR ..
RUN rm -fr cmake-3.9.1.tar.gz cmake-3.9.1


COPY rustc-1.19.0-src.tar.gz .
RUN tar xfz rustc-1.19.0-src.tar.gz
WORKDIR rustc-1.19.0-src
RUN ./configure --prefix=/usr/local
RUN make
RUN make install
WORKDIR ..
RUN rm -fr rustc-1.19.0-src.tar.gz rustc-1.19.0-src


RUN yum -y -q install git grub2 grub2-tools


RUN useradd -M jafager

RUN mkdir /home/jafager && chown jafager:jafager /home/jafager && chmod 700 /home/jafager
WORKDIR /home/jafager
COPY bash_profile .bash_profile
COPY bashrc .bashrc
COPY vimrc .vimrc
RUN chown jafager:jafager .bash_profile .bashrc .vimrc && chmod 600 .bash_profile .bashrc .vimrc

RUN mkdir local && chown jafager:jafager local && chmod 700 local
RUN mkdir local/bin && chown jafager:jafager local/bin && chmod 700 local/bin
WORKDIR local/bin
COPY abbreviate_cwd .
RUN chown jafager:jafager abbreviate_cwd && chmod 700 abbreviate_cwd
RUN yum -y -q install perl

USER jafager
WORKDIR /home/jafager
CMD bash --login
