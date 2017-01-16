This repository provides all the files needed to create lightweight docker
images of Elixir apps, for development, and for releases, using Distillery:

# Features

- the development environment runs in a docker container,
- the code is editable from the host (it's just mounted as a volume in the
  container),
- one script to pass commands to the development container,
- one script to create a self contained docker image of a Distillery release,
- lightweight:

    - development image: 38MB,
    - release image: 27MB.

# Usage

## Build the docker needed docker images

- Alpine linux

    if your machine architecture is x86_64, then ignore this step, linux alpine will
    be pulled automatically:

    ```
    $ cd dockerfiles/alpine
    $ ./mkimage-alpine.sh
    $ cd ../..
    ```

- Elixir-dev

    This image is based on Alpine linux, and contains Erlang, Elixir,
    and also installs `hex` and `rebar`:

    ```
    $ cd 1-elixir-dev
    $ ./build.sh
    $ cd ..
    ```

- Elixir-phoenix-dev

    This image is based on elixir-dev and installs `inotify-tools` and the
    Phoenix framework on top:

    ```
    $ cd 2-phoenix-dev
    $ ./build.sh
    $ cd ..
    ```

- Alpine-base

    This image is based onthe Alpine image, and just adds `ncurses-libs`.
    The release images will be based on this one.

    ```
    $ cd 3-alpine-base
    $ ./build.sh
    $ cd ../..
    ```

## Start coding !

Use the `run-dev.sh` to run command in the elixir/Phoenix dev environement:

```
$ # create a new Phoenix app. Use '.' as destination:
$ ./run-dev.sh mix phoenix.new . --app my_app --no-ecto --no-brunch
$ # run it:
$ ./run-dev.sh mix phoenix.server
```

At this point a new directory named `app` has been created and mounted as
a volume in the container, and the Phoenix server is running using the mix
"dev" environment and listening on http://localhost:4000.

You can edit the app right from the host, just as if it was normally
installed.

## Prepare Phoenix for deployment

Check the guide at http://www.phoenixframework.org/docs/deployment.
At minimum, edit `app/config/prod.exs` and uncomment the line:

```
#     config :phoenix, :serve_endpoints, true
```

## Prepare your app for a Distillery release

Check the [Distillery documentation](https://hexdocs.pm/distillery) for that.
Basically:

- add `{:distillery, "~> 1.1}` in the mix dependencies,
- run `$ ./run-dev.sh mix deps.get`
- run `$ ./run-dev.sh mix release.init`
- edit `app/rel/config.exs` for your needs.

## Create the Distillery release in a docker image:

```
$ ./make-release.sh
```

This will create a Distillery release and include it in a image based on
the "alpine-base" image,  built earlier.
See the dockerfile used in "dockerfiles/phoenix-release".

```
$ docker images
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
my_app                       0.0.1               e83228567eb0        10 seconds ago      26.76 MB
my_app                       latest              e83228567eb0        10 seconds ago      26.76 MB
(...)

```

By default the image name and tag are the name and version of the mix app.

At this point the image is ready to use. The default port is 8000, and has
to be bound to a host port:

```
$ docker run --rm -it -p 8000:8000 my_app:0.0.1
19:14:46.805 [info] Running MyApp.Endpoint with Cowboy using http://localhost:8000
```

# Links

- [Elixir](http://elixir-lang.org/),
- [Phoenix-framework](http://www.phoenixframework.org/),
- Distillery: [github](https://github.com/bitwalker/distillery), [documentation](https://hexdocs.pm/distillery).
