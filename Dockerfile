FROM openjdk:17-jdk-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH $PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

# Install system packages
RUN apt-get update && apt-get install -y curl unzip git wget

# Install Android SDK + cmdline-tools properly
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip sdk.zip -d $ANDROID_SDK_ROOT/cmdline-tools && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses && \
    yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager \
        "platform-tools" \
        "platforms;android-34" \
        "build-tools;34.0.0"

# (OPTIONAL) Skip Gradle install; use ./gradlew instead
# If you insist on manual install, match version in gradle-wrapper.properties:
# RUN wget https://services.gradle.org/distributions/gradle-8.11.1-bin.zip && \
#     unzip gradle-8.11.1-bin.zip -d /opt && \
#     ln -s /opt/gradle-8.11.1/bin/gradle /usr/bin/gradle

WORKDIR /app
