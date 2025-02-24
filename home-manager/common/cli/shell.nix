{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  #zsh 
  programs.zsh = {
    enable = true;
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}