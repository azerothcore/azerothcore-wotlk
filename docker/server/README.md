# AzerothCore Dockerized

This provides a way to pull, build and run AzerothCore worldserver, authserver and database.

## Requirements

- [Docker](https://docs.docker.com/install/)
- Docker-Compose (installed by default with Docker)

- AzerothCore **data files** copy-pasted in the `docker/server/data` folder. If you don't have them yet, check the step ["Download the data files" from the installation guide](http://www.azerothcore.org/wiki/Installation#5-download-the-data-files).
It should look like this:
```
.
├── docker
  ├── server
    ├── data
      ├── Cameras
      ├── dbc
      ├── maps
      ├── mmaps
      ├── vmaps
```

## Running the setup

*Inside the root folder of this repository.*

1. Optionnally run `docker-compose pull` to pull already built images and get started quickly
2. Run `docker-compose up --build`
