# snort-secmon

![](https://github.com/nu11secur1ty/snort/blob/master/logo/586e6b2cc2d41da57a33ca0d.png)

--------------------------------------------------------------------------------

[Snort](https://www.snort.org/) in Docker for Network Functions Virtualization (NFV)

The Snort Version 2.9.8.0 and DAQ Version 2.0.6

- - - Maintenance and testing on 2.9.16

# Docker Usage
You may need to run as `sudo`
Attach the snort in container to have full access to the network

- - - Login:

```bash
docker run -t -i nu11secur1ty/snort /bin/bash
```
- - - Dirrect to `/opt/`

```
docker run -it --rm --net=host nu11secur1ty/snort /bin/bash
```

Or you may need to add --cap-add=NET_ADMIN or --privileged (unsafe)

```
docker run -it --rm --net=host --cap-add=NET_ADMIN nu11secur1ty/snort /bin/bash
```


# Snort Usage

![](https://github.com/nu11secur1ty/snort/blob/master/usage/snort.gif)

For testing it's work. Add this rule in the file at `/etc/snort/rules/local.rules`

`alert icmp any any -> any any (msg:"Pinging...";sid:1000004;)`

Running Snort and alerts output to the console (screen).


- - - ***NOTE:*** Use your network interface

```
$ snort -i wlan0 -c /etc/snort/etc/snort.conf -A console
```

Running Snort and alerts output to the UNIX socket

```
snort -i eth0 -A unsock -l /tmp -c /etc/snort/etc/snort.conf
```

Ping in the container then the alert message will show on the console

```
ping 8.8.8.8
```
