# Dockermation

Dockermation provides a set of Docker containers for local Laravel development. It is based on Laradock and bundles multiple services such as MySQL, Nginx and a PHP workspace. The project includes a helper script `initServer.sh` to bootstrap everything automatically.

## Prerequisites

- **Docker** and **Docker Compose** must be installed on your host.
- **Git** for fetching the project and optional branch setup.
- Make sure your user can run Docker commands without sudo.

## Quick start

1. Clone this repository.
2. Run the initialization script from the project root:
   ```bash
   ./initServer.sh
   ```
   The script will:
   - initialise the git repository if one is not found;
   - interactively create the Laravel `.env` file;
   - copy `docker/env-example` to `docker/.env` and build the images;
   - start the containers with `docker-compose`;
   - run Composer and Laravel setup commands inside the workspace container.

Once complete, the application will be accessible on the ports configured in `docker/.env` (by default Nginx listens on port 80).

## Managing the containers

After the first run you can start the environment manually:

```bash
cd docker
docker-compose up -d
```

To stop the services use `docker-compose down`. Most services and PHP options can be customised through the variables in `docker/.env`.

## Environment variables and customisation

The file `docker/env-example` lists all available options. Copy it to `docker/.env` and adjust values as required. A few useful settings include:

- `PHP_VERSION` – selects the PHP version used by the `workspace` and `php-fpm` containers.
- `WORKSPACE_INSTALL_NODE`, `WORKSPACE_INSTALL_YARN`, etc. – toggle installation of additional tools inside the workspace image.
- `MYSQL_VERSION`, `REDIS_PORT`, and similar variables configure service versions and ports.

Review the file for more options such as enabling Xdebug, choosing a different database engine, or changing default ports.

## Upgrading

If any base image versions change or you update the `PHP_VERSION` variable, rebuild the containers to apply the changes:

```bash
cd docker
docker-compose pull
docker-compose build --no-cache
docker-compose up -d
```

Rebuilding ensures that new images are downloaded and all containers use the latest configuration.
