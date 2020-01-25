FROM mono:6.8.0.96

ARG VERSION

RUN groupadd --gid=9117 jackett && \
    useradd --create-home --home-dir=/home/jackett --gid=9117 --shell /bin/bash --uid 9117 jackett && \
    mkdir /data /downloads /opt/jackett && \
    curl --location --output /tmp/jackett.tar.gz --silent "https://github.com/Jackett/Jackett/releases/download/v${VERSION}/Jackett.Binaries.Mono.tar.gz" && \
    tar xzf /tmp/jackett.tar.gz --directory=/opt/jackett --strip-components=1 && \
    nuget install -OutputDirectory /tmp -Verbosity quiet -Version 5.4.0.201 Mono.Security && \
    mv /tmp/Mono.Security.5.4.0.201/build/net45/win/Mono.Security.dll /opt/jackett && \
    rm -fr /tmp/Mono.Security.5.4.0.201 && \
    chown --recursive 9117:9117 /data /downloads /opt/jackett

USER 9117
VOLUME /data /downloads
WORKDIR /home/jackett

EXPOSE 9117
ENTRYPOINT ["mono", "/opt/jackett/JackettConsole.exe", "--DataFolder=/data"]
