# Imagem base: Ubuntu LTS (sem Snapd)
FROM ubuntu:22.04

# Variáveis de ambiente recomendadas
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Instalar dependências do AOSP/AAOS
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    git \
    curl \
    wget \
    unzip \
    zip \
    python3 \
    python3-pip \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    ninja-build \
    ccache \
    libncurses5 \
    libncurses5-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    zlib1g-dev \
    bc \
    flex \
    bison \
    gperf \
    rsync \
	git-core gnupg flex bison build-essential zip curl zlib1g-dev \
	gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
	libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig \
	python3 python-is-python3 openjdk-11-jdk openjdk-8-jdk qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libxcb-xinerama0 libxcb-xinerama0-dev qtwayland5 \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário não-root para compilar
RUN useradd -m builder
USER builder
WORKDIR /home/builder

# Configurar ccache (opcional, acelera builds repetidos)
ENV USE_CCACHE=1
ENV CCACHE_DIR=/home/builder/.ccache

# Diretório do código-fonte
# (Você vai montar o seu repo local aqui via volume)
VOLUME ["/home/builder/aosp"]

# Comando padrão: abrir shell
CMD ["/bin/bash"]

