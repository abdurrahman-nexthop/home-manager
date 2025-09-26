# Setting up development VM

## Install Nix 

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Make sure to logout and log back in.

## Enable Nix experimental features

Add the following to /etc/nix/nix.conf:
```
experimental-features = nix-command flakes
```

## Clone Abdurrahman's Home Manager config

```sh
git clone https://github.com/abdurrahman-nexthop/home-manager.git ~/.config/home-manager
```

## Build the initial configuration

```sh
nix run nixpkgs#home-manager build
```

## Activate

```sh
./result/activate
```

You can remove `result` link after activation.
