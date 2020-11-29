# Installing taxonworks on Windows 10 with WSL2

## Introduction

Windows 10 now has Linux available natively via `WSL2` (`Windows Subsystem for
Linux v2`). `WSL2` runs a real Linux kernel and is much faster than the first
iteration, `WSL1`, however it is still noticeably slower than Linux installed
on a 'bare metal'.

Taxonworks can be developed using `WSL2` and Docker. This document describes to
to set everything up starting with enabling `WSL2` on Windows 10.

## Preparation

Note: The installation procedure changes with time while `WSL2` matures. This
section describes installation procedure for Windows 10 October 2020 edition.

* Run all Windows updates to make sure you are at the latest Windows 10 version.

* Install `Windows Terminal` (optional)

    Windows Terminal is an Open Source project from Microsoft that provides a
    pretty nice terminal emulator. I would say the quality of it is approaching
    the quality of popular terminal emulators on Mac and Linux. It is highly
    configurabele and allows to run PowerShell, CMD, and Linux.

    To install it, open `Windows Store` app and search for `Windows Terminal`.

* Install `Visual Studio Code` (optional)

   WSL2 does not have native support for graphical programs yet (it is
   planned).  However Visual Studio Code, a popular code editor, supports a
   transparent "bridge" to Linux from WSL. You can download it at
   `https://code.visualstudio.com/download`

## Install WSL2

Open PowerShell as administrator (standalone or as Windows Terminal) and type
the following commands:

* Enable WSL2

    ```bash
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```

* Enable Virtual Machine Platform

    ```bash
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```
    Restart your computer.

* Setup WDL v2 as default

    ```bash
    wsl --set-default-version 2
    ```

## Install Linux Distro

There are several Linux distros available for WSL2, in our example we
use Ubuntu 20.04.

Go to `Microsoft Store` app, search for Ubuntu, install and launch it. You will
see it appearing in a separate terminal this time. You can customize it right
in the terminal, or you can close it, and reopen it in `Windows Terminal`,
where it will appear now as an option.

Once Ubuntu 20.04 is installed, open it in the Windows Terminal, run:

```bash
sudo apt update
sudo apt dist-upgrade
```

## Install Docker Desktop for Windows 10

Download installer for Docker Desktop from the [Docker
Hub](https://docs.docker.com/docker-for-windows/install/) and run the
installation. Docker Desktop will also install hooks into WSL2, so you do not
need to install Docker one more time on WSL2 Linux.

Now open Linux in Windows Terminal or its native terminal and try to run
`docker` or `docker-compose` commands. If you get errors that tell you do not
have enough privileges, run ``sudo vim /etc/group`` and check that your account
is added to docker group. For example I set my account as `dimus` and the line
about docker group looks like this for me:

```txt
...
docker:x:1001:dimus
...
```

You might need to relog or restart the machine to get docker permissions to
work correctly.

## Clone the taxonworks source code

Go to an appropriate directory in your Linux terminal and run

```bash
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
docker-compose build
docker-compose up
```

* browse to `127.0.0.1:3000` if you can see something similar to below in
  your terminal window:

    ```bash
    webpack_1  | webpack: Compiled successfully.
    ```

* You should see the logon window. Minimally, you now need to _Create a user_
  or _Restore a database dump_
* Wait for a while if the logon window does not load not load quickly.
* Use `ctrl-c` or `docker-compose down` in another local terminal to shutdown

## Run the tests

```bash
docker-compose exec run bash
```

From the inside of the container run:

```bash
rake db:migrate RAILS_ENV=test
rspec
```

On my laptop tests finished in 31 minute.

## Setup a development environment

You can use Vim, Neovim, Emacs etc from inside of the terminal to develop
taxonworks code.

If you prefer a graphical interface of Visual Studio code you can launch is by
simply going inside of the taxonwork directory and running

```bash
code .
```

VS Code will start a network bridge to WSL2 Linux behind the scene and will
make it possible to develop and debug code. The terminal in the VS Code will
also run Linux.
