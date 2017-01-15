FROM ybycode/alpine-base:latest
WORKDIR /app
CMD [ "./bin/run", "foreground" ]

# build arguments
ARG appName

# default env vars
ENV REPLACE_OS_VARS=true
ENV PORT=8000
ENV HOST=example.com

ADD ./${appName}.tar.gz /app
RUN ln -s /app/bin/${appName} /app/bin/run

