FROM openjdk:17-jdk-slim

# Install required packages
RUN apt-get update && apt-get install -y curl unzip git wget

# Android SDK variables
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH $PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools

# Install SDK
RUN mkdir -p $ANDROID_SDK_ROOT && \
    cd $ANDROID_SDK_ROOT && \
    curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip sdk.zip -d cmdline-tools && \
    mv cmdline-tools cmdline-tools/latest && \
    yes | cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_SDK_ROOT \
      "platform-tools" \
      "platforms;android-34" \
      "build-tools;34.0.0" \
      "cmdline-tools;latest"

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-8.4-bin.zip && \
    unzip gradle-8.4-bin.zip -d /opt && \
    ln -s /opt/gradle-8.4/bin/gradle /usr/bin/gradle

WORKDIR /app
