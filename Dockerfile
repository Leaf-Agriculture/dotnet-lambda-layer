FROM lambci/lambda:build

ARG DOTNET_VERSION

WORKDIR /tmp/build

RUN curl -L -o install.sh https://dot.net/v1/dotnet-install.sh && \
    bash install.sh \
        --verbose \
        --channel ${DOTNET_VERSION} \
        --install-dir /opt/share/dotnet \
        --runtime dotnet

RUN mkdir -pv /opt/bin && ln -s /opt/share/dotnet/dotnet /opt/bin/dotnet
