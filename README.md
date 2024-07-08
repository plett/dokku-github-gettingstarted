# Dokku and Github Actions

Deploy the Docker [getting-started app][dockerapp] on a [Dokku][dokku] host
using [Github Actions][githubactions] for deployment and [Dependabot][dependabot]
for security patching.

[dockerapp]: https://github.com/docker/getting-started-app/tree/main
[dokku]: https://dokku.com/
[githubactions]: https://docs.github.com/en/actions
[dependabot]: https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide

This is a learning exercise to see how to fit all these pieces together.

## Pre-requisites

- A Dokku host. [Installation instructions](https://dokku.com/docs/getting-started/installation/).
  Personal preference is a Debian host, Dokku installed from packages,
  unattended-upgrades to keep packages current
- The [dokku-acl](https://github.com/dokku-community/dokku-acl) plugin to
  restrict which ssh keys can control which apps.
- a container based app to deploy. I'm using the [Docker workshop guide](https://docs.docker.com/guides/workshop/02_our_app/).

## Deployment with Github Actions

When a commit happens on the `main` branch, we want Github to run an Action
which deploys the new version of the app and makes it live

### Generate ssh key
### Create user in Dokku using public key
- set the name field
### Create the app
- letsencrypt?
### Grant permissions for this user to this app
- mention default open perms
### Give private key to Github
- consider environments and protected branches

## Dependabot for version upgrades
- wants to keep Dockerfile `FROM` dependencies up to date
- also Github Action versions

## Testing
- Automated testing of the changed app
  - build and test app entirely within Github Actions
  - deploy the code under a unique hostname and test it remotely
- Review app for every PR (including both human dev and dependabot ones) for
  human UAT before merging.
