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
Run `build-and-start-containers.sh` and direct your browser to
http://localhost:10000/index.html?encoding=rgb32&password=111 . This should give
you an in-browser VNC session with Spacemacs.

Add `ghc` as project with `C-c C-p a ghc` and open any Haskell file under
`compiler/`. Accept the default for the workpace.

Building the images takes a long time. Stay patient: It downloads everything
that's needed to build GHC and later even builds it from scratch.

### Cleanup
Run `cleanup.sh` to remove the two created containers.

### Screenshots

Information on hover:
![Hover](screenshot_01.png)

Type error:
![Type Error](screenshot_02.png)

