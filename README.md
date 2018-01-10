Transmission Daemon
===================

Very light **transmission-daemon** installation based on the slim python image that supports many architectures (amd64, ARM for the Raspberry Pi, etc).

By design, it will only run the **transission** daemon, exposing its standard
port and exporting volumes for both the *configuration* and the *data*
(including download) directories.

You can execute it with:

```
export TORRENT_DIR=/media/external

docker volume create transmission_config

docker run -d \
  -p  9091:9091 \
  -p  51413:51413 \
  -p  51413:51413/udp \
  --restart='always' \
  -v $TORRENT_DIR:/var/lib/transmission-daemon/downloads \
  -v transmission_config:/etc/transmission-daemon \
  --name transmission carlosedp/rpi-transmission
```

In my case, `/media/external` represents an external drive mounted on the docker
host, and the Docker volume transmission_config contains all the settings for the container.

The use of `restart='always'` ensures the container starts with the docker host.

The default username and password for the Web GUI is "transmission". To change the username or password, edit the config file using the procedure below:

1. Find the Docker volume path with: `docker volume inspect transmission_config`
2. Stop the container with `docker stop transmission`
3. Edit  *as root* the settings.json file in the path listed on "Mountpoint" config from the command 1.
4. Change the "rpc-username" and "rpc-password" parameters. The password will be encrypted when the daemon starts.
5. Start the container with `docker start transmission`
