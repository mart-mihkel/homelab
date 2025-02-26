{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    ref = "minimal";
    rev = "sha1-Wm0qYj+gezeOH5TNklyGEhnvg9k=";
  };
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    defaultEditor = true;

    extraPackages = with pkgs; [ ripgrep ];
  };

  home.file.".config/nvim".source = conf.outPath + "/.config/nvim";
}
