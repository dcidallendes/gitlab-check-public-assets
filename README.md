# Gitlab check public  assets

A ruby script that searchs for public repos, groups and user groups in a given Gitlab server.

## Usage

### From console

You may run the following command:

``` 
ruby gitlab-check-public-assets.rb
```

### Prerequisites

An access token with `read_repository` scope is required in order to access your Gitlab project.

Ruby and `gitlab` gem are required if the script is run from console.
