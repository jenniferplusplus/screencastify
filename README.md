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


# Notes for Submission

## Implementation Overview

At a high level, the project uses docker to build a container image for the app. From there, Docker-compose is used to coordinate running that container along with the database container and related networks and persistent volumes. All of that configuration is contained in the `Dockerfile` and `docker-compose.yml` in the project root. Shell scripts are provided in the `./scripts` directory which encapsulate the docker-compose commands needed to initially create the development environment including creating the mongo database, as well as start the services and run tests.

Regarding CICD, that is provided via github actions, which trigger on pushes and PRs to the `main` branch. The Current CI pipeline runs unit tests with Mocha and verifies linting passes with Prettier. This is done as native actions (not in a container) to avoid the extra time required to build the image. As-is, the pipeline completes in about 30 seconds, not counting time spent in the Actions queue.

The code itself is almost entirely unmodified from the template provided by Keystone. It's been formatted by Prettier, and it was updated to take the mongodb host from an environment variable.

## Production and Staging Environments

To make this application production ready, some solution would need to be implemented for secrets management, and config management generally. The nature of that would likely depend on the deployment details. With a managed cloud container service, it would likely make sense to use the cloud host's managed config services as well. In a kubernetes deployment, the best option is probably K8's own Secrets management and ConfigMaps.

Once that config solution is in place, the Dockerfile can be updated to run the app in production mode, rather than development. This definition could also exclude development dependencies (mocha and prettier) from the install, to make builds and deploys faster. A second Dockerfile could be created for development use, to enable dev and debugging features. Or alternatively, it may be possible to get the same result with a multi-stage Dockerfile definition. That would have the advantage of eliminating bugs caused by forgetting to update either the dev or production file. But, tbh, it's been a long time since I used them, and I'm not completely certain it's possible.

Finally, the CD pipeline would need to be updated to actually build the image and do something with it. Preferably, upload it to an image registry and then trigger deployment steps. I think making deployments as automatic as possible is a good thing. It promotes good habits, like making frequent small changes rather than infrequent large ones. And it enables the shortest feedback loop for the team. With that in mind, my ideal extension would be to deploy the newly built changes to staging as soon as they're ready and CI passes. And then deploy to production once the PR is merged. Or even better, deploy the pre-merge changes to an ephemeral environment that's created on the fly and destroyed once the PR closes, one way or the other.

## Accessing Staging Data in Development

This is a hard question to answer because I think it really depends on the details of the deployment. I think the two options would be to allow dev environments to simply connect to staging services, or to enable taking snapshots/backups of the staging database and restoring it to a development database. It's hard to say which is better in a purely hypothetical way.

## Monitoring, Alerting, and Observability

This would need to be improved substantially. The application only does whatever logging is provided by Keystone. Ideally, this would actually take the form of distributed tracing. But the application would need to be instrumented for that. I think good templates and guidance around tracing is a very valuable thing for a platform or devops team to provide.

Alerting is, again, heavily influenced by the nature of deployment. Any container orchestration solution can detect and respond to the state of the containers, and that would form the basis of events to alert on. Things like containers crashing, failing to start, error responses, and scaling events are good places to start alerting. As a project matures, those alerts should be revisited and ideally tailored around intentional service level objectives, rather than raw infrastructure events.