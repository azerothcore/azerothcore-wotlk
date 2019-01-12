TODO

```docker build -t azerothcore/worldserver -f docker/worldserver/Dockerfile docker/worldserver```

```docker run --name azt-worldserver --mount type=bind,source=/mnt/70DD9E0635B3A813/azeroth-server/data,target=/azeroth-server/data --network host azerothcore/worldserver```
