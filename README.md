# Dockermation

This repository contains helper scripts for bootstrapping a development
environment. The main entry point is `initServer.sh` which builds the
Docker containers and generates an `.env` file with the required secrets.

## Rotating Secrets

The `.env` file is only generated if it does not already exist. If you
need to rotate sensitive values such as the `JWT_SECRET` or the FCM
credentials, remove the existing `.env` file and rerun
`./initServer.sh`. The script will create new random tokens and rebuild
the containers using the updated configuration.
