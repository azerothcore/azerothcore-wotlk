TODO - I'll write this soon

`docker build -t azerothcore/database -f docker/DB/Dockerfile .`

`docker run --name azt-db -p 127.0.0.1:9000:3306 -e MYSQL_ROOT_PASSWORD=password azerothcore/database`

`docker run --name azt-db -p 9000:3306 -e MYSQL_ROOT_PASSWORD=password azerothcore/database`
