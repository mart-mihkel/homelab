# homelab🤖

Nix configuration for stuff

## Init

```bash
nix-shell -p vim -p git --experimental-features 'nix-command flakes'
nixos-rebuild switch --flake .#[host]
```
