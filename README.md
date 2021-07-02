
# sbt
- [Overview](#Overview)
- [Quick Links](#Quick-Links)
- [Prerequisites](#Prerequisites)
- [FAQs](#FAQs)

## Overview
Yet another `sbt` Docker image ...  Check the [FAQs](#FAQs) for why.

## Quick Links
- [sbt Reference Manual ](https://www.scala-sbt.org/1.x/docs/)
- [sbt Downloads](https://www.scala-sbt.org/download.html)

## Prerequisites
- [GNU make](https://www.gnu.org/software/make/manual/make.html>)

## Getting Started
### Help
There should be a `make` target to be able to get most things done.  Check the help for more information:
```
make help
```
### Building the Local Environment
Get the code and change into the top level `git` project directory:
```
git clone git@github.com:loum/sbt.git && cd sbt
```
Run all commands from the top-level directory of the `git` repository.
For first-time setup, get the [Makester project](https://github.com/loum/makester.git):
```
git submodule update --init
```
Initialise the environment:
```
make init
```
#### Local Environment Maintenance
Keep [Makester project](https://github.com/loum/makester.git) up-to-date with:
```
git submodule update --remote --merge
```
### Building the Docker Image
```
make build-image
```
### Searching `sbt` Docker Images
To list the available `sbt` Docker images::
```
make search-image
```
### Docker Image Version Tag
```
make tag-version
```
Tagging convention used is:
```
alpine<ALPINE_DOCKER_VERSION>-<SBT_VERSION>-<MAKESTER__RELEASE_NUMBER>
```
`latest` tag is created with:
```
make tag-latest
```
## Useful Commands
### `make run`
Start a pristine `sbt` container from the new image build.  No `sbt` dependencies are cached.

### `make sbt`
Run `sbt` REPL with host cached files mapped as Docker volumes to the guest.

### `make sbt CMD=<cmd>`
Run `sbt` subcommand as per `CMD`.  

 ### `make sbt-help`
 Display the `sbt` help messge.
 
 ### `make sbt-version`
 Display basic information about `sbt` and the build.
 
 ### `make console`
 Starts the Scala interpreter with the project classes on the classpath.

## FAQs
***Q. Why another sbt Docker image?***
- Security
  - Working for an organisation that take Security to the next level, I've created this simple [sbt](https://www.scala-sbt.org/1.x/docs/) client based off the most recent Alpine.  My adjustments include:
  - latest [Alpine Docker image](https://hub.docker.com/_/alpine) to stay a step ahead of [CVEs[(https://cve.mitre.org/)
  - create a dedicated `sbt` user with UID `30998` to get around our Kubernetes cluster policy constraints
- Portability 
  - control your `sbt` and `java` versions within the container so you don't have to mess up your local development environment 
  - if you create products that support a broad developer user base across various development environments and just want stuff to work?  Then containerise it and be done with it
