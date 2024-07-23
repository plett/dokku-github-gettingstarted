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
  restrict which ssh keys can control which apps. When installing it, read the
  docs - especially the section on `default behavior`. You want to explicitly
  set an admin user to prevent every user being an admin.
- a container based app to deploy. I'm using the [Docker workshop guide](https://docs.docker.com/guides/workshop/02_our_app/).

## Deployment with Github Actions

When a commit happens on the `main` branch, we want Github to run an Action
which deploys the new version of the app and makes it live

### Generate ssh key
```
ssh-keygen -t ed25519 -f githubdeploykey
```

### Create user in Dokku using public key
Transfer the public key to your dokku host, then create a named user which uses
it.
```
sudo dokku ssh-keys:add githubgettingstarted /tmp/githubdeploy.pub
```
### Create the app
```
dokku apps:create gettingstarted
```
- letsencrypt?
### Grant permissions for this user to this app
```
dokku acl:add gettingstarted githubgettingstarted
```

### Give private key to Github
To ensure that only workflows that run on the `main` branch can deploy to
github, my recommended path is to make an Environment called `Production`
and restrict access to it only the selected branch `main`.
Then create an Environment Secret called `SSH_PRIVATE_KEY` and paste the private
key from earlier in to it

## CI deploys
We want every commit to `main` to trigger an update of the dokku app. See the
[workflow file](.github/workflows/deploy.yaml) in this repo for an example which
is derived from the [dokku github action](https://github.com/dokku/github-action).

## Dependabot for version upgrades
- wants to keep Dockerfile `FROM` dependencies up to date
- also Github Action versions

## Testing
- Automated testing of the changed app
  - build and test app entirely within Github Actions
  - deploy the code under a unique hostname and test it remotely
- Review app for every PR (including both human dev and dependabot ones) for
  human UAT before merging.
