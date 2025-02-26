{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];

    shellAliases = {
      tn = "tmux new-session -s";
      ta = "tmux attach -d -t";
    };

    initExtra = ''
      PS1="\[\033[01;34m\]\W\[\033[00m\] "

      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      bind "TAB:menu-complete"
    '';
  };
}
