FROM openjdk:16-slim AS dev

# ENV PATH /usr/local/kotlinc/bin:$PATH
ENV SRC /usr/local/kotlin
# ENV VERSION 1.4.10
ENV GRADLE_VERSION 6.7.1
ENV PATH /usr/local/gradle-$GRADLE_VERSION/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /usr/local && \
    rm gradle-${GRADLE_VERSION}-bin.zip && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]


FROM dev AS builder
COPY ./src $SRC
RUN kotlinc $SRC -include-runtime -d $SRC/main.jar
CMD ["/bin/sh", "-c", "$JAVA_HOME/bin/java -jar $SRC/main.jar"]


FROM adoptopenjdk/openjdk11:alpine-slim AS exe
ENV SRC /usr/local/kotlin
COPY --from=builder $SRC/main.jar $SRC/main.jar
CMD ["/bin/sh", "-c", "$JAVA_HOME/bin/java -jar $SRC/main.jar"]
