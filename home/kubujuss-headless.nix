{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "sha1-nMVLHMDMLc73NeR98s3dIqnW4Jk=";
    ref = "tty";
  };
in
{
  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      extraPackages = with pkgs; [ ripgrep ];
    };

    git = {
      enable = true;
      userName = "mart-mihkel";
      userEmail = "mart.mihkel.aun@gmail.com";

      extraConfig = {
        core.editor = "nvim";
        pull.rebase = true;
      };
    };

    zsh = {
      enable = true;

      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = ["completion" "history"];
      };

      shellAliases = {
        ls = "ls --color";
        l = "ls -A --color";
      };

      completionInit = ''
        autoload -Uz compinit && compinit
        zstyle ":completion:*" special-dirs true
        zstyle ":completion::complete:*" gain-privileges 1
      '';

      initExtra = ''
        PROMPT="%F{4}%1~ %f"
        RPROMPT="%F{8}$(git symbolic-ref --short HEAD 2> /dev/null)%f"
        ZSH_AUTOSUGGEST_STRATEGY=(completion history)

        setopt no_case_glob no_case_match
        setopt inc_append_history share_history hist_ignore_dups

        bindkey "^w" forward-word
        bindkey "^b" backward-word
        bindkey "^k" up-line-or-history
        bindkey "^j" down-line-or-history

        tm() {
            sessions=$(tmux ls)
            dir=$(find ~/git ~/ut -mindepth 1 -maxdepth 1 -type d | fzf --header "$sessions" --header-border sharp --header-label "Sessions")

            if [[ -z $dir ]]; then
                return
            fi

            session=$(basename $dir | tr . _)

            if [[ -z $TMUX ]]; then
                tmux new-session -Ac $dir -s $session
                return
            fi

            if ! tmux has-session -t $session 2> /dev/null; then
                tmux new-session -dc $dir -s $session
            fi

            client=$(tmux display-message -p '#{client_name}')
            tmux switch-client -c $client -t $session
        }
      '';
    };
  };

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";

    file.".config/nvim".source = conf.outPath + "/.config/nvim";
    file.".config/tmux".source = conf.outPath + "/.config/tmux";

    stateVersion = "24.05";
  };
}
