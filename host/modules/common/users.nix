{ pkgs, ... }:

{
  users.users = {
    kubujuss = {
      shell = pkgs.zsh;
      createHome = true;
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
    };
  };
}
