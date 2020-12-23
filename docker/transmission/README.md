# Docker - Transmission

Transmission running in a docker container with `docker-compose`.

## 1. Docker compose config

Example directory `.../Transmission` (for example in `$HOME`):
```
.
├── docker-compose.yml
├── downloads/
├── watch/
└── wg/
    ├── privatekey
    └── publickey
```

In `wg/` generate the keys according to the vpn provider instructions.

In `docker-compose.yml`:
- Replace `/path/to/downloads` by `.../Transmission/downloads`
- Replace `/path/to/watch` by `.../Transmission/watch`

## 2. Wireguard config

Sample wireguard config file to place in `/opt/docker/volumes/wireguard-transmission/config/wg0.conf`:

```
[Interface]
PrivateKey = <my-pubkey>    # host private key in wg/privatekey
Address = <vpn-my-ip>       # host IP assigned by the vpn provider
DNS = <vpn-my-dns>          # DNS assigned by the vpn provider

[Peer]
PublicKey = <vpn-privkey>               # vpn server public key
Endpoint = <vpn-address>:<vpn-port>     # vpn server address
AllowedIPs = 0.0.0.0/0
```

## 3. Launch the container

```
cd .../Transmission
docker-compose up -d
```

## 4. Launch transmission client

- Use `ip a show dev docker0` to get the docker local ip.
- Download `transmission-gtk` or `transmission-qt`
- Edit > Change Session > Connect to remote session
    - Host: <docker-ip>
    - Port: 9091

## 5. Quality control

### Container IP and geolocation

```
# Should display the home public ip and geolocation
curl ipinfo.io
# Should display the vpn public ip and geolocation
docker exec transmission sh -c 'curl ipinfo.io'
```

### Network disabled in case of vpn outage

```
# Stop the vpn container
docker stop wireguard-transmission
# Requesting the ip info should result in an error
docker exec transmission sh -c 'curl ipinfo.io'
# Restart everything clean
docker-compose down
docker-compose up -d
```
