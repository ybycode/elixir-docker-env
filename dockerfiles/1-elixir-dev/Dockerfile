FROM alpine:3.5

ARG elixirVersion

RUN apk --update add \
        erlang \
        erlang-crypto \
        erlang-syntax-tools \
        erlang-parsetools \
        erlang-inets \
        erlang-ssl \
        erlang-public-key \
        erlang-eunit \
        erlang-asn1 \
        erlang-sasl \
        erlang-erl-interface \
        erlang-dev \
 && apk add --virtual build-dependencies \
        git \
        wget \
        ca-certificates \

 && wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${elixirVersion}/Precompiled.zip \
 && mkdir -p /opt/elixir-${elixirVersion}/ \
 && unzip Precompiled.zip -d /opt/elixir-${elixirVersion}/ \

 && rm Precompiled.zip \
 && apk del build-dependencies \
 && rm -rf /etc/ssl \
 && rm -rf /var/cache/apk/*

ENV PATH $PATH:/opt/elixir-${elixirVersion}/bin

RUN mix local.hex --force && \
    mix local.rebar --force

CMD ["/bin/sh"]
