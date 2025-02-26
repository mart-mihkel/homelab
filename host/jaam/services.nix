{ config, pkgs, ... }:

let
  tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  token = config.sops.secrets."tunnel/jaam/token".path;
in
{
  imports = [
    ../modules/services/jupyterhub.nix
  ];

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
  };

  systemd.services.tunnel = {
    after = [ "network.target" "systemd-resolved.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/bin/sh -c '${tunnel} --token $(cat ${token})'";
      Restart = "always";
    };
  };

  networking.firewall.allowedTCPPorts = [
    22 # ssh
  ];
}
