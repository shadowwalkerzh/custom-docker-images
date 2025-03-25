# custom-docker-images
This repository customizes a series of infrastructure Docker compose files to make your development easier and quicker, all of them are **Production Ready**. It provides dockercompose files for infra and database images like: Timezone based `Alpine`, Timezone based `Python`, `MySQL`, `MongoDB`, `Redis`, `RabbitMQ`, `Elasticsearch`, `Nginx` etc.

## infra-images

### alpine-shanghai-base
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"

### python2.7-shanghai-base
- Official Python 2.7
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"

### python3.9-shanghai-base
- Official Python 3.9
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"

## db-images

### docker-compose_pub-mysql.yml
> pub-mysql is based on `MySQL 8.0` official images to customize the JSON log file and volumes, set the default root password to `admin`, create a default database `test` with a fully granted account name `user`, password `changeMe123`. The default MySQL version is `8.0`.

#### How to run the MySQL server 8.0?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-mysql.yml up -d -v`

#### How to access MySQL from the Docker host?
- You can also use MysqlWorkbench or Navicat to connect the Mysql Server. (**High Recommended**)

### docker-compose_pub-mongodb.yml
> pub-mongodb is based on `MongoDB 8.0` official images to customize the JSON log file and volumes, set the default root user `root` and password `root`. The default MongoDB version is `8.0`. And there is UI service `mongo-express` to help access this mongodb from website.

#### How to run MongoDB 8.0 and mongo-express?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-mongodb.yml up -d -v`

#### How to access MongoDB from the Docker host?
- Install the latest MongoDB client:
  - Please install `mongodb-mongosh` to acccess MongoDB 8.0:
    ```sh
    sudo apt-get update && sudo apt-get install -y mongodb-mongosh
    ```
  - Check the installed version: `mongosh --version`
  - Connect: `mongosh "mongodb://<username>:<password>@<host>:<port>"`

### docker-compose_pub-redis.yml
> pub-redis is based on `Redis 8.0` official images to customize the JSON log file and volumes, set the default password `redis_pass`. The default Redis version is `8.0`.

#### How to run the pub-redis?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-redis.yml up -d -v`

#### How to access pub-redis from the Docker host?
```sh
- Install redis client: `sudo apt-get install redis-tools`
- Login redis: 
  - `redis-cli`
  - `auth redis_pass`
```

### docker-compoe_pub-rabbigmq.yml
> pub-rabbigmq is based on `Rabbigmq 4.0` official images to customize the JSON log file and volumes, both of the default user and password are `admin`. The default Rabbigmq version is `4.0`. If you want to install some customized plugins, please edit file `production_ready_rabbitmq-enabled_plugins` and mount it to config directory, then restart service.

#### How to run the pub-rabbigmq?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-rabbigmq.yml up -d -v`

#### How to access pub-rabbigmq from the Docker host?
> Visit `http://localhost:15672` in your local browser


### docker-compose_pub-elasticsearch.yml (Develop)
> pub-elasticsearch is based on `Elasticsearch 8` official images to customize the JSON log file and volumes. The default version is `8.17.0`. `develop_elasticsearch-standalone.yml` is the standalone elasticsearch configuration file, you can adjust your config here. Please make sure your compose file and configuration file are in the same directory.

#### How to run the pub-elasticsearch?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-elasticsearch.yml up -d -v`


### docker-compose_pub-elasticsearch-cluster.yml (Production)
> pub-elasticsearch-cluster is based on `Elasticsearch 8` official images to customize the JSON log file and volumes. The default version is `8.17.0`. `production_ready-elasticsearch-cluster.yml` is the cluster elasticsearch configuration file, you can adjust your config here. Please make sure your compose file and configuration file are in the same directory.

#### How to run the pub-elasticsearch?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/docker-compose_pub-elasticsearch-cluster.yml up -d -v`


### docker-compose_pub-nginx.yml
> pub-nginx is based on `Nginx 1.27` official images to customize the JSON log file and volumes. The default Rabbigmq version is `1.27-alpine`. Please relace all the sample configs and files before running on production. Read more configuration details [Here](https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-nginx/README.md).

#### How to run the pub-nginx?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-nginx/docker-compose_pub-nginx.yml up -d -v`



# References
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)