{ pkgs, ... }:

{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    neofetch
    gnumake
    ripgrep
    neovim
    nodejs
    cargo
    tmux
    curl
    wget
    tree
    btop
    zsh
    wol
    git
    gcc
    vim
    fzf
    uv
    jq
  ];
}
