# ghc-spacemacs-docker

This is a showcase how to use the language servers (LSP servers) `ghcide` and
`ccls` with Spacemacs in Docker.

It's not meant for daily work! At least `git` is not correctly configured and
everything happens as `root` user.

You can use the files in `config/` to setup Spacemacs as your GHC IDE. Please see
https://gitlab.haskell.org/ghc/ghc/wikis/spacemacs for details.

The most important part of this little project is to show how to configure
`ghcide` for your local GHC project:

- `config/.spacemacs` contains only as much changes to the Spacemacs template as
  needed.
- `config/ghc` can be seen as an "overlay" to your GHC source folder. Copy these
  files into your GHC source folder according to the directory structure of
  `config/ghc`.

## Usage

### Run
#### Pre-built docker image
There is a pre-built docker image
(https://hub.docker.com/r/supersven/ghc-spacemacs). It is pretty big (3.65 GB),
but contains the GHC clone and Spacemacs with all needed packages.

To use it, run `start-containers.sh`.

You can still change the `config/.spacemacs` file, because it is mounted into on
container creation. The other files are copyied into the image; if you want to
change them, you've to change them manually in the container instance.

#### Manually built docker image

Run `build-and-start-containers.sh`, this builds the docker image.

Building the image takes a long time. Stay patient: It downloads everything
that's needed to build GHC and later even builds it from scratch.

#### VNC - Open Spacemacs

Both scripts start a VNC server with a web interface. Direct your browser to
http://localhost:10000/index.html?encoding=rgb32&password=111 . This should give
you an in-browser VNC session with Spacemacs.

Open Treemacs with `M-0` and add `/root/ghc/.` as project. Open any Haskell file
under `compiler/`. You will be asked for the workspace root. The default -
`/root/ghc` is fine.

The `ghcide` setup take some time to initialize.

All `*.c` files under `rts` should be supported by `ccls`. Just open one and play a
bit around ... :smiley

### Cleanup
Before you can run the two creational scripts (`build-and-start-containers.sh`
and `start-containers.sh`) again, you have to stop and remove the containers.
This is done by running `cleanup.sh`.

### Screenshots

#### Haskell
Information on hover:
![Hover](screenshot_01.png)

Type error:
![Type Error](screenshot_02.png)

#### C
Information on hover (Please note the function type in the left corner):
![C - Hover](screenshot_03.png)

Error (unknown function):
![C - Error (unknown function)](screenshot_04.png)
