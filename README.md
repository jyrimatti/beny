# Homekit.sh plugin for ZJ Beny EV charger

Prerequisites
-------------
- get a computer (e.g. a server or a Raspberry Pi)
- install [Nix](https://nixos.org/download/)
- install [Homekit.sh](https://github.com/jyrimatti/homekit.sh)

Or:
- Nix is only to manage dependencies, you can install all manually if you prefer.
- Homekit.sh is not necessary if you only want to use this as scripts directly.

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

FAQ
---

1. How to find out Beny IP address?
   
   Check your router's DHCP client list or use a network scanner to find the device. You might also want to make it static if your DHCP tends to change it.

2. How to find out the Beny port?
   
   For me the port is 3333, but I don't know if that applies globally.

3. A script is not working, what to do?
   
   I've reverse-engineered part of the Beny API with WireShark and Beny mobile application. I'm only guessing what to send and how to parse the response, so there's a high chance I didn't guess something correctly. Please open an issue and I'll try to help you.

4. A script used to work but stopped working, what to do?
   
   Beny may have changed their API. Please open an issue and I'll try to fix it.
