# KeystoneJS Todo List Template

You've created a KeystoneJS project! This project contains an example of a basic Todo list. Look at the `index.js` file to see how the list is configured. It also contains a StaticApp that provides an example of simple front-end application that makes use of the graphQL API. Take a look at the `public` folder to see how this application is built.

## Getting Started

After you clone the repository and install Docker and Docker-compose, you can get started with a single command.

```
./scripts/run.sh
```
Depending on your configured permissions, you likely need to run these scripts with superuser permissions (sudo). You can fix this by creating a `docker` user group on your local machine and adding yourself to it.

## Development

For your convenience, there is a dockerized development environment provided for this app. This allows you to build, test, and run the application with only docker and docker-compose as dependencies. You will need to install those as normal for your environment. On Windows, using WSL is likely the easiest path to a working docker environment. The `run` and `test` scripts will both execute `init` if the application has not already been initialized. You can rerun `init` as needed to rebuild the application container/image.


* `scripts/init.sh` Builds the containers, volumes, and networks required by the application services.
* `scripts/run.sh` Starts the application services. Once running, the application will be available on http://localhost:3000. Your local source code directory will be mounted as a volume in the container, which will allow you to observe your changes without rebuilding the image first. The application container also forwards port 9229 which you can use to connect the nodejs remote debugger.
* `scripts/test.sh` Runs the suite of unit tests in the app container
