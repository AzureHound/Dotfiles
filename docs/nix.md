# Nix

```sh
sudo nix flake update
```

```sh
sudo nixos-rebuild switch --flake /etc/nixos
```

# Optimize

```sh
nixos-rebuild switch --list-generations
```

```sh
sudo nix-store --optimize
```

```sh
sudo nix-collect-garbage -d
```

```sh
sudo nix-collect-garbage -d --delete-older-than 14d
```

# Applications dir

```sh
cd /run/current-system/sw/share/applications/
cd /etc/profiles/per-user/$USER/share/applications/
```

# ISO

```sh
nix build ".#nixosConfigurations.Nyx.config.system.build.isoImage"
```

# NixOS Anywhere

```sh
nmtui

ping 1.1.1.1

ip addr

sudo su
passwd
```

```sh
cd ~/Developer/NixOS-Anywhere
git checkout Legion

nix run github:nix-community/nixos-anywhere -- \
  --flake ".#Legion" \
  --build-on remote \
  root@10.10.0.4
```
