# rclone-docker

[![version)](https://img.shields.io/docker/v/crashvb/rclone/latest)](https://hub.docker.com/repository/docker/crashvb/rclone)
[![image size](https://img.shields.io/docker/image-size/crashvb/rclone/latest)](https://hub.docker.com/repository/docker/crashvb/rclone)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/rclone-docker.svg)](https://github.com/crashvb/rclone-docker/blob/master/LICENSE.md)


## Overview

This docker image contains [rclone](https://rclone.org/).

## Entrypoint Scripts

### rclone

The embedded entrypoint script is located at `/etc/entrypoint.d/rclone` and performs the following actions:

1. A new rclone configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | -------- | ------------- | ----------- |
 | RCLONE\_CONF | | If defined, this value will be written to `<rclone_conf>/rclone.conf`. |

2. Volume permissions are normalized.

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ cron.daily/
│  │  └─ rclone
│  ├─ rclone/
│  └─ entrypoint.d/
│     └─ rclone
├─ run/
│  └─ secrets/
├─ usr/
│  └─ local/
│     └─ bin/
│        ├─ rclone-down
│        ├─ rclone-up
│        └─ rclone-wrapper
└─ var/
   ├─ lib/
   │  └─ rclone/
   └─ log/
      └─ rclone*
```

### Exposed Ports

None.

### Volumes

* `/etc/rclone` - rclone configuration directory.
* `/var/lib/rclone` - rclone data directory.

## Development

[Source Control](https://github.com/crashvb/rclone-docker)

