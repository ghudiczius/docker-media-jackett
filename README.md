# Bazarr

Simple docker image for Jackett without any bloat, built on the official mono image. Jackett runs as user `jackett` with `uid` and `gid` 9117.

## Usage

```sh
docker run --rm ghudiczius/jackett:<VERSION> \
  -p 9117:9117 \
  -v path/to/data:/data \
  -v path/to/downloads:/downloads
```
