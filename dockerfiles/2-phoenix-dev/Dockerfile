FROM ybycode/elixir-dev:latest

ARG phoenixVersion

RUN mix archive.install --force \
    https://github.com/phoenixframework/archives/raw/master/phoenix_new-${phoenixVersion}.ez

# needed for the automatic recompilation and page reload:
RUN apk --update add \
        nodejs \
        inotify-tools \
    && rm -rf /var/cache/apk/*

CMD [ "/bin/sh" ]
