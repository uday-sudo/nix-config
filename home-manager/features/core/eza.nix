{
  config,
  pkgs,
  ...
}: {
  programs.eza = {
    enable = true;

    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;

    # Set custom options for eza
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
    icons = "auto";
    colors = "auto";
  };

  home.shellAliases = {
    ls = "eza";
    l = "eza -la";
  };
}
