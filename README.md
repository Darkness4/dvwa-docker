# DVWA Proper Container

Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that is damn vulnerable. Its main goal is to be an aid for security professionals to test their skills and tools in a legal environment, help web developers better understand the processes of securing web applications and to aid both students & teachers to learn about web application security in a controlled class room environment.

The aim of DVWA is to practice some of the most common web vulnerability, with various difficultly levels, with a simple straightforward interface. Please note, there are both documented and undocumented vulnerability with this software. This is intentional. You are encouraged to try and discover as many issues as possible.

**WARNING** This image is vulnerable to several kinds of attacks, please don't deploy it to any public servers.

## Run this image by pulling it

A docker compose:

```
version: '3.9'

services:
  dvwa:
    image: ghcr.io/darkness4/dvwa:2.0.1
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - '3000:80'
    depends_on:
      - database
    environment:
      WAIT_HOSTS: database:3306
      WAIT_HOSTS_TIMEOUT: 300
      WAIT_SLEEP_INTERVAL: 30
      WAIT_HOST_CONNECT_TIMEOUT: 30
    volumes:
      - ./config:/config

  database:
    image: library/mariadb:10.7
    ports:
      - '3306:3306'
    environment:
      MYSQL_ROOT_PASSWORD: localrootpassword
      MYSQL_DATABASE: dvwa
      MYSQL_USER: dvwa
      MYSQL_PASSWORD: p@ssw0rd
    volumes:
      - 'database_data:/var/lib/mysql'

volumes:
  database_data:

```

## Run this image by building it

Clone this repository.

To run this image you need [docker](http://docker.com) and docker-compose installed. Just run the command:

    docker compose up -d --build

You can access to the server by going to http://localhost:3000

Then, just click on the `Create / Reset database` button and it will generate any additional configuration needed.

The database may takes time to initialize, so don't be surprised if you received some "connection refused" errors.

## Login with default credentials

To login you can use the following credentials:

- Username: admin
- Password: password

## About DVWA

You can visit DVWA [official website](http://www.dvwa.co.uk/) and official [github repository](https://github.com/digininja/DVWA) if you want more information.

## Disclaimer

This or previous program is for Educational purpose ONLY. Do not use it without permission. The usual disclaimer applies, especially the fact that me (Marc Nguyen) is not liable for any damages caused by direct or indirect use of the information or functionality provided by these programs. The author or any Internet provider bears NO responsibility for content or misuse of these programs or any derivatives thereof. By using these programs you accept the fact that any damage (dataloss, system crash, system compromise, etc.) caused by the use of these programs is not Marc Nguyen's responsibility.
