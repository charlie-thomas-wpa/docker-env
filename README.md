# docker-env

## build
```bash
docker compose build --no-cache
```

## run
The following will run the container with default behaviour.  
Point to a different .env or modify the existing to provide different environment variables.  

### *I should note the following:*
- .env must contain ALL environment variables specified in entrypoint.sh
- .env must provide values for all environment variables specified in entrypoint.sh.
- .env may contain MORE environment variables than specified in entrypoint.sh, though will incur warnings.
- entrypoint.sh running with `-e` mandates immediate exit if a command exits with a non-zero status (error).


```bash
# Test env
$env:ENV_FILE="oingo.env"; docker compose up

# Dev env
$env:ENV_FILE="DevOingo.env"; docker compose up

# Stg env
$env:ENV_FILE="StgOingo.env"; docker compose up

# LiVe env
$env:ENV_FILE="LiveOingo.env"; docker compose up
```

## run without auto
```bash
# Test env
$env:ENV_FILE="oingo.env"; docker compose run --rm -it --entrypoint /bin/bash oingo-boingo

# Dev env
$env:ENV_FILE="DevOingo.env"; docker compose run --rm -it --entrypoint /bin/bash oingo-boingo

# Stg env
$env:ENV_FILE="StgOingo.env"; docker compose run --rm -it --entrypoint /bin/bash oingo-boingo

# LiVe env
$env:ENV_FILE="LiveOingo.env"; docker compose run --rm -it --entrypoint /bin/bash oingo-boingo
```

| Component                  | Purpose                                                                                                       |
| :------------------------: | ------------------------------------------------------------------------------------------------------------- |
| `docker compose`	         | *Uses Docker Compose to manage multi-container applications.*                                                 |
| `run`	                     | *Runs a single service defined in the docker-compose.yml file.*                                               |
| `--rm`	                 | *Automatically removes the container once it stops (keeps things clean).*                                     |
| `-it`	                     | *Allocates an interactive terminal (-i for interactive, -t for TTY).*                                         |
| `--entrypoint /bin/bash`   | *Overrides the default entrypoint of the container, launching a Bash shell instead of the default command.*   |
| `oingo-boingo`             | *The service name (defined in docker-compose.yml).*                                                           |

To run the C# project included in this repository when bypassing the `entrypoint.sh` file, run the following commands:

```bash
> cd src/OingoBoingo/OingoBoingo  
> dotnet restore  
> dotnet build  
> dotnet run  
```