FROM openjdk:16-slim AS dev

ENV PATH /usr/local/kotlinc/bin:$PATH
ENV SRC /usr/local/src
ENV VERSION 1.4.10

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget unzip && \
    wget https://github.com/JetBrains/kotlin/releases/download/v$VERSION/kotlin-compiler-$VERSION.zip && \
    unzip kotlin-compiler-$VERSION.zip -d /usr/local && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm kotlin-compiler-$VERSION.zip

CMD ["/bin/bash"]


FROM dev AS builder
COPY ./src $SRC
RUN kotlinc $SRC -include-runtime -d $SRC/main.jar
CMD ["/bin/sh", "-c", "$JAVA_HOME/bin/java -jar $SRC/main.jar"]


FROM adoptopenjdk/openjdk11:alpine-slim AS exe
ENV SRC /usr/local/src
COPY --from=builder $SRC/main.jar $SRC/main.jar
CMD ["/bin/sh", "-c", "$JAVA_HOME/bin/java -jar $SRC/main.jar"]
