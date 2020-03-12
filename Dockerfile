FROM lambci/lambda:build


WORKDIR /tmp/build

RUN curl -L -o install.sh https://dot.net/v1/dotnet-install.sh

ARG DOTNET_VERSION

RUN bash install.sh \
        --verbose \
        --channel $DOTNET_VERSION \
        --install-dir /opt/share/dotnet \
        --runtime dotnet && \
    rm -f install.sh

RUN mkdir -pv /opt/bin && ln -s /opt/share/dotnet/dotnet /opt/bin/dotnet
