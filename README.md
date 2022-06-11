# Docker Jenkins

This compose file allows to bootstrap an instance of the latest
Jenkins [Docker image](https://hub.docker.com/_/jenkins/) mounting a persistent data storage within the working directory of the host machine.

```

/var/jenkins_home is mounted under ${PWD}/jenkins

```

## Installation

docker-compose up -d

### Requirements

Docker Version >= 1.12.2

### Setup

git clone git@github.com:p0bailey/docker-jenkins.git

## Usage

```
docker-compose up -d
```

Grab Jenkins initial admin password.
```
cat jenkins/secrets/initialAdminPassword
```

Point the browser to:

```
127.0.0.1:8080
```

Go and set up Jenkins.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

16 Oct 2016 - 1.0

## Author

Phillip Bailey - <phillip@bailey.st>

## License

MIT License
