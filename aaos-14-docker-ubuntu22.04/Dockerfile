# Imagem base: Ubuntu LTS (sem Snapd)
FROM ubuntu:22.04

# Variáveis de ambiente recomendadas
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Instalar dependências do AOSP/AAOS
RUN apt-get update && apt-get install -y \
    # Core build tools
    openjdk-17-jdk \
	openjdk-11-jdk \
    openjdk-8-jdk \
    git \
    curl \
    wget \
    unzip \
    zip \
    python3 \
    python3-pip \
    python-is-python3 \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    ninja-build \
    ccache \
    flex \
    bison \
    gperf \
    rsync \
    bc \
    zlib1g-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    libncurses5 \
    libncurses5-dev \
    lib32ncurses5-dev \
    libc6-dev-i386 \
    gcc-multilib \
    g++-multilib \
    lib32z1-dev \
    libgl1-mesa-dev \
    fontconfig \
    x11proto-core-dev \
    libx11-dev \
    gnupg \
    # Qt5 runtime and dev packages (no qt5-default)
    qtbase5-dev \
    qtbase5-dev-tools \
    qtchooser \
    qt5-qmake \
    qtbase5-private-dev \
    libqt5gui5 \
    libqt5widgets5 \
    libqt5core5a \
    libxcb-xinerama0 \
    libxcb-xinerama0-dev \
    qtwayland5 \
    # Emulator/X11 runtime dependencies
    libx11-6 \
    libxcb1 \
    libxext6 \
    libxrender1 \
    libxrandr2 \
    libxi6 \
    libxfixes3 \
    libxcursor1 \
    libxkbcommon0 \
    libglu1-mesa \
    libgl1-mesa-glx \
    # Virtualization support
    qemu-kvm \
    libvirt-clients \
    libvirt-daemon-system \
    # Optional: virtual framebuffer for headless mode
    xvfb \
    tzdata \
    pulseaudio \
    alsa-utils \
    libasound2 \
    libnss3 \
    libc6 \
    libstdc++6 \
    libxcomposite1 \
    libxdamage1 \
    libxss1 \
    libxtst6 \
    adb \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME and PATH to Java 17
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Android SDK command-line tools
ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
    && cd $ANDROID_SDK_ROOT/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip \
    && rm cmdline-tools.zip \
    && mv cmdline-tools latest

# Add sdkmanager to PATH
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH


# Make sure you have the Android SDK tools installed (sdkmanager and avdmanager). If not, install them in your Dockerfile:
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "emulator" \
               "system-images;android-34;google_apis;x86_64"

# Ensure timezone data exists
ENV TZ=UTC

# Set Qt plugin path for emulator
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/home/builder/aosp/prebuilts/android-emulator/linux-x86_64/lib64/qt/plugins

# Default to using X11 forwarding; can override with xvfb-run
ENV DISPLAY=:0
    
# Criar usuário não-root para compilar
RUN useradd -m builder
USER builder
WORKDIR /home/builder

# Configurar ccache (opcional, acelera builds repetidos)
ENV USE_CCACHE=1
ENV CCACHE_DIR=/home/builder/.ccache

# Set Android emulator environment paths
RUN mkdir -p /home/builder/.android/avd
RUN chown -R builder:builder /home/builder/.android

ENV ANDROID_EMULATOR_HOME=/home/builder/.android
ENV ANDROID_AVD_HOME=/home/builder/.android/avd

USER builder
WORKDIR /home/builder/aosp

# The emulator checks $XDG_RUNTIME_DIR first. Inside Docker it often points to /run/user/1000. You can override it to point at your .android directory:
ENV XDG_RUNTIME_DIR=/home/builder/.android


# Diretório do código-fonte
# (Você vai montar o seu repo local aqui via volume)
VOLUME ["/home/builder/aosp"]

# Comando padrão: abrir shell
CMD ["/bin/bash"]

