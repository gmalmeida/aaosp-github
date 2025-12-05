# Imagem base: Ubuntu LTS (sem Snapd)
FROM ubuntu:24.04

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev \
    lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip \
    fontconfig rsync && apt-get clean

RUN apt-get update && apt-get install -y \
	wget \
    openjdk-17

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

