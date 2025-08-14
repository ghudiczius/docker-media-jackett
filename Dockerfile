FROM debian:13.0

ARG VERSION

# renovate: release=trixie depName=curl
ENV CURL_VERSION=7.88.1-10+deb12u12
# renovate: release=trixie depName=libicu76
ENV LIBICU_VERSION=72.1-3

RUN apt-get update --quiet && \
    apt-get --assume-yes --quiet install \
        curl="${CURL_VERSION}" \
        libicu72="${LIBICU_VERSION}" && \
    groupadd --gid=1000 jackett && \
    useradd --gid=1000 --home-dir=/opt/jackett --no-create-home --shell /bin/bash --uid 1000 jackett && \
    mkdir /data /downloads /opt/jackett && \
    curl --location --output /tmp/jackett.tar.gz --silent "https://github.com/Jackett/Jackett/releases/download/v${VERSION}/Jackett.Binaries.LinuxAMDx64.tar.gz" && \
    tar xzf /tmp/jackett.tar.gz --directory=/opt/jackett --strip-components=1 && \
    chown --recursive 1000:1000 /data /downloads /opt/jackett && \
    rm /tmp/jackett.tar.gz

USER 1000
VOLUME /data /downloads
WORKDIR /home/jackett

EXPOSE 9117
ENTRYPOINT ["/opt/jackett/jackett"]
CMD ["--DataFolder=/data"]
