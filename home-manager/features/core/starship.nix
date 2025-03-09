{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = config.programs.bash.enable;
    enableZshIntegration = config.programs.zsh.enable;

    settings = {
      # Inserts a blank line between shell prompts
      add_newline = true;

      # Custom format
      format = ''
        $directory$git_branch$git_status$cmd_duration
        $character
      '';

      # cmd_duration module
      cmd_duration = {
        min_time = 500;
        format = "[ $duration](bold yellow)";
      };

      # character module
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      # directory module
      directory = {
        truncation_length = 6;
        truncation_symbol = "…/";
        truncate_to_repo = false;
      };

      # git_branch module
      git_branch = {
        symbol = " ";
        truncation_length = 4;
        truncation_symbol = "...";
      };

      # git_status module
      git_status = {
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };

      # package module
      package = {
        disabled = true;
      };
    };
  };
}
