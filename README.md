# Homekit.sh plugin for ZJ Beny EV charger

Prerequisites
-------------
- get a computer (e.g. a server or a Raspberry Pi)
- install [Nix](https://nixos.org/download/)
- install [Homekit.sh](https://github.com/jyrimatti/homekit.sh)

Setup for home automation
-------------------------

```
cd ~/.config/homekit.sh/accessories
```

Clone this repo
```
git clone https://github.com/jyrimatti/beny.git
cd beny
```

Store Beny address/hostname and port
```
echo '<my beny address/hostname>' > .beny-host
echo '<my beny port>' > .beny-port
chmod go-rwx .beny*
```
