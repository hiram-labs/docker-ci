## CI/CD

1. jenkins

---

### Requirements

- docker
- docker compose

---

### Dev setup

```
start your docker client
git clone https://github.com/hiram-labs/docker-ci.git
docker-ci
```

---

### Commands

**_HINT_** `chmod 700 run`

Use the `./run` shell script to execute the following commands:

- start the docker-compose file in detach mode

```
./run start
```

- stop the docker-compose file

```
./run stop
```

- get shell into jenkins container

```
./run jkn:shell
```
