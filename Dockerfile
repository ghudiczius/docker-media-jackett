FROM debian:10.2

ARG VERSION

RUN apt-get update --quiet && \
    apt-get --assume-yes --quiet install curl libicu63 && \
    groupadd --gid=9117 jackett && \
    useradd --create-home --home-dir=/home/jackett --gid=9117 --shell /bin/bash --uid 9117 jackett && \
    mkdir /data /downloads /opt/jackett && \
    curl --location --output /tmp/jackett.tar.gz --silent "https://github.com/Jackett/Jackett/releases/download/v${VERSION}/Jackett.Binaries.LinuxAMDx64.tar.gz" && \
    tar xzf /tmp/jackett.tar.gz --directory=/opt/jackett --strip-components=1 && \
    chown --recursive 9117:9117 /data /downloads /opt/jackett

USER 9117
VOLUME /data /downloads
WORKDIR /home/jackett

EXPOSE 9117
ENTRYPOINT ["jackett", "--DataFolder=/data"]
