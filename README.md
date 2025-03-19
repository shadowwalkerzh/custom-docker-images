# custom-docker-images
This repository customizes a series of infrastructure Docker images to make your development easier and quicker. It provides infra images for Alpine with timezone `Asia/Shanghai`, Python 2.7 and Python 3.9 with timezone `Asia/Shanghai`, MySQL image `pub-mysql`, and MongoDB image `pub-mongodb`.

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

### pub-mysql
> pub-mysql is based on MySQL official images to customize the JSON log file and volumes, set the default root password to `admin`, create a default database `test` with a fully granted account name `user`, password `changeMe123`. The default MySQL version is `5.7`. If you want to use `8.0` or higher, please edit `options` file with `export IMAGE_VERSION=8.0` first and then run the `docker-compose_pub-mysql.yml`.

#### How to run the MySQL server 5.7?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-mysql/docker-compose_pub-mysql.yml up -d -v`

#### How to run the MySQL server 8.0?
- `export IMAGE_VERSION=8.0`
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-mysql/docker-compose_pub-mysql.yml up -d -v`

#### How to access MySQL from the Docker host?
- Install MySQL client: `sudo apt-get install mysql-client-core-5.7`
- Create mysqld directory if not existing: `sudo mkdir -p /var/run/mysqld`
- Create mysqld link: `sudo ln -s /opt/pub-mysql/data/mysqld/mysqld.sock /var/run/mysqld/mysqld.sock`
- Login to MySQL: `mysql -uuser -pchangeMe123`

### pub-mongodb
> pub-mongodb is based on MongoDB official images to customize the JSON log file and volumes, set the default root user `root` and password `root`. The default MongoDB version is `4.2.0`. If you want to use a higher version like `8.0`, please edit `options` file with `export IMAGE_VERSION=8.0` first and then run the `docker-compose_pub-mongodb.yml`.

#### How to run MongoDB 4.2.0?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/develop/db-images/pub-mongodb/docker-compose_pub-mongodb.yml up -d -v`

#### How to run MongoDB 8.0?
- `export IMAGE_VERSION=8.0`
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/develop/db-images/pub-mongodb/docker-compose_pub-mongodb.yml up -d -v`

#### How to access MongoDB from the Docker host?
- Install the latest MongoDB client:
  - Add the official MongoDB repository:
    ```sh
    # Ubuntu-18.04:
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

    # Ubuntu-16.04:
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

    # Ubuntu-14.04:
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

    # MongoDB 8.0
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    ```
  - Import the public key:
    ```sh
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ```
  - Install the latest version of the Mongo shell:
    ```sh
    sudo apt-get update
    sudo apt-get install -y mongodb-org-shell
    ```
  - To install a specific version of the Mongo shell, run:
    ```sh
    sudo apt-get install -y mongodb-org-shell=4.2.0
    ```
  - Check the installed version: `mongo --version`
  - Connect:
    ```sh
    mongo
    use admin
    db.auth("root","root")
    ```

  - If you are running MongoDB `8.0`, please install `mongodb-mongosh`:
    ```sh
    sudo apt-get update && sudo apt-get install -y mongodb-mongosh
    ```
  - Check the installed version: `mongosh --version`
  - Connect: `mongosh "mongodb://<username>:<password>@<host>:<port>"`

### pub-redis
> pub-redis is based on Redis official images to customize the JSON log file and volumes, set the default password `redis_pass`. The default Redis version is `4.0`. If you want to use a higher version like `8.0`, please edit `options` file with `export IMAGE_VERSION=8.0` first and then run the `docker-compose_pub-redis.yml`.

#### How to run the pub-mysql?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-redis/docker-compose_pub-redis.yml up -d -v`

#### How to access pub-redis from the Docker host?
```sh
- Install redis client: `sudo apt-get install redis-tools`
- Login redis: 
  - `redis-cli`
  - `auth redis_pass`
```


# References
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)