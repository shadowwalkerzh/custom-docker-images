# custom-docker-images
This repository is to customize a series of infrastructure docker images to make your development easier and quicker. Provide infra images alpine with timezone `Asia/Shanghai`, python2.7 and python 3.9 with timezone `Asia/Shanghai`, mysql image `pub-mysql` and mongodb image `pub-mongodb`.

## infra-images
### alpine-shanghai-base
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"


### python2.7-shanghai-base
- Official python2.7
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"


### python3.9-shanghai-base
- Official python3.9
- Add timezone "Asia/Shanghai"
- Add Locale "en_US.UTF-8"


## db-images
### pub-mysql
> pub-mysql is based on Mysql official images to customize the json log file and volumes, set default root password to `admin`, create default database `test` with full granted account name `user`, password `changeMe123`. Default mysql version is `5.7`, if you want to use `8.0` or higher, please `export IMAGE_TAG=8.0` first and then run the `docker-compose_pub-mysql.yml`
#### How to run the mysql server 5.7?
-  `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-mysql/docker-compose_pub-mysql.yml up -d -v`
#### How to run the mysql server 8.0?
-  `export IMAGE_TAG=8.0`
-  `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/master/db-images/pub-mysql/docker-compose_pub-mysql.yml up -d -v`

#### How to access to mysql from docker host?
- Install mysql client: `sudo apt-get install mysql-client-core-5.7`
- Create mysqld directory if not existed: `sudo mkdir -p /var/run/mysqld`
- Create mysqld link: `sudo ln -s /opt/pub-mysql/data/mysqld/mysqld.sock /var/run/mysqld/mysqld.sock`
- Login mysql: `mysql -uuser -pchangeMe123` 


### pub-mongodb
> pub-mysql is based on MongoDB official images to customize the json log file and volumes, set default root user `root` and password `root`. Default mongodb version is `4.2.0`, if you want to use higher version like `8.0`, please `export IMAGE_TAG=8.0` first and then run the `docker-compose_pub-mongodb.yml`
#### How to run the mongodb 4.2.0?
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/develop/db-images/pub-mongodb/docker-compose_pub-mongodb.yml up -d -v`
#### How to run the mongodb 8.0?
- `export IMAGE_TAG=8.0`
- `docker-compose -f https://github.com/shadowwalkerzh/custom-docker-images/blob/develop/db-images/pub-mongodb/docker-compose_pub-mongodb.yml up -d -v`

#### How to access to mongodb from docker host?
- Install latest mongodb client:
  - Add the official MongoDB repository
    ```
      # Ubuntu-18.04:
      $ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" \
      | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

      # Ubuntu-16.04:
      $ echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" \
      | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

      # Ubuntu-14.04:
      $ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.2 multiverse" \
      | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

      # Mongodb 8.0
      $ echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" \
      | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    ```
  - Import the public key:
    ```
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
    ```
  - Install the latest version of mongo shell:
    ```
      sudo apt-get update
      sudo apt-get install -y mongodb-org-shell
    ```
    
  - To install a specific version of mongo shell, run:
    - ```sudo apt-get install -y mongodb-org-shell=4.2.0```
    - Check the installed version: `mongo --version`
    - Connect: 
        - `mongo`
        - `use admin`
        - `db.auth("root","root")`
  
  - If you are running mongodb `8.0`, please install `mongodb-mongosh`:
    - ```sudo apt-get update && sudo apt-get install -y mongodb-mongosh```
    - Check the installed version: `mongosh --version`
    - Connect: `mongosh "mongodb://<username>:<password>@<host>:<port>"`



# References
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)