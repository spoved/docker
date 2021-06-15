FROM ubuntu:xenial as build
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*
WORKDIR /tmp
RUN wget https://github.com/felipegiacomozzi/the-trove-downloader/releases/download/1.0.17/linux-x64.zip && \
  unzip linux-x64.zip && \
  chmod +x TheTroveDownloader && \
  cp TheTroveDownloader /bin/trovedl
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
WORKDIR /

# FROM microsoft/dotnet:2.2-runtime-stretch-slim-arm32v7
# COPY --from=build /bin/trovedl /bin/trovedl