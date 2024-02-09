# A docker container that runs a dedicated modded Steam Proton PalWorld server.

since most mods for palworld uses UE4SS and UE4SS only supports windows; using this docker setup will allow you to run the windows server under linux (using proton)

## Instructions
- build the docker image
```
./docker/build-docker-image.sh
```

- (optional) make .env file and edit settings
```
cp env.sample .env
vi .env
...
```

- start the server
```
docker compose up -d
```

- (optional) check docker log
```
docker compose logs -f
```

- shutdown server
```
docker compose down
```


## Files
the server installation will be under `server/PalServer`, this is where you can go install mods

## Backups
there's automatic hourly backup of the server save, backups will be in `server/backups`, you can change the frequency in `./server/crontab`

## Installed Mods
.dll files in the /palworld/Pal/Binaries/Win64/Mods folder
- Barrens Chat: https://www.nexusmods.com/palworld/mods/293
- Better Riding (Ground Mounts): https://www.nexusmods.com/palworld/mods/375
- Bigger and Reorganized Palbox: https://www.nexusmods.com/palworld/mods/68
- Dedicated Server Build Overlap: https://www.nexusmods.com/palworld/mods/182
- Extended Building Reach: https://www.nexusmods.com/palworld/mods/139
- Hungry Pal Rescuer: https://www.nexusmods.com/palworld/mods/497
- Less Resrictive Building: https://www.nexusmods.com/palworld/mods/98
- Pal Force Feeder: https://www.nexusmods.com/palworld/mods/313
- Server Essentials: https://www.nexusmods.com/palworld/mods/340
  

.pak files in the /palworld/Pal/Content/Paks folder
- Floating Building Fix: https://www.nexusmods.com/palworld/mods/149
- Katress Hat Drop: https://www.nexusmods.com/palworld/mods/377
- Open Gate Fix: https://www.nexusmods.com/palworld/mods/357
- Zoom's Schematic Drop Buff: https://www.nexusmods.com/palworld/mods/359
