# docker-ttyd

This is a dockerized version of [ttyd](https://github.com/tsl0922/ttyd), a
utility that allows you to access a command line from your web browser.
This container is designed to be used as a minimal Alpine Linux-based
environment, complete with user accounts and optional root access. 

## Usage

Pull ttyd from the Docker Hub

    docker pull mrtux543/ttyd:latest

Create a `.env` file with your desired environment variables. An example with
the defaults is in this repo.

Create a ttyd container:

    docker run -p 7681:7681 --name=ttyd --env-file=.env mrtux543/ttyd

ttyd is now accessible at `http://localhost:7681`

## Environment variables

Docker-ttyd uses the following environment variables:

| Variable  | Description | Default Value |
|-----------|-------------|---------------|
| USERNAME  | The username your shell will run as. | `user` |
| PASSWORD  | The password your user account uses. **Change this!** | `Passw0rd` |
| SUDO_OK   | If enabled, the user account will have access to `sudo`. | `false` |
| AUTOLOGIN | Automatically logs in as your user, without a password. | `false` |
