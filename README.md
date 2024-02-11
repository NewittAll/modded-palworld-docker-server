# A docker container that runs a dedicated modded Steam Proton PalWorld server.
Built based on using https://github.com/peepoturtle/palworld-docker-proton-server as a base and uses functions from https://github.com/jammsen/docker-palworld-dedicated-server for backup, rcon, webhooks, and server settings setup.
Most mods for Palworld require UE4SS which only supports Windows; this docker container runs Steam on Proton allowing you host a server with mods.

## Instructions
- Modify copy and rename default to .env and modify to setup Palworld server settings
```
cp default.env .env
vi .env
```

- Build the docker image
```
docker image build -t modded-palworld-docker-server .
```


- Start the server and check the logs to be sure everything boots up properly
```
docker compose up -d && docker compose logs -f
```
The server will print ">>> Starting Palworld Server <<<" into the logs and will sit on "wine: RLIMIT_NICE is <= 20, unable to use setpriority safely" that means the server has succesfully booted.

- shutdown server
```
docker compose down
```

To install mods place them in the mods folder, pak files mods into the pak folder, dlls and luas mods into the Win64 folder so that they will be moved to the correct location.

## Files
The server installation will be under `/palworld` directoy, all downloaded files are stored in `/palworld/Downloads`, and scripts in `/palworld/Scripts`.

## Backups
There's automatic daily backup of the server save, backups are stored in the `/palworld/Backups` directory, backup schedule can be changed by modifying `BACKUP_CRON_EXPRESSION` in .env file. (Crontab format generator can be used here https://crontab.guru/#0_23_*_*_*)
