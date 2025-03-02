{inputs, pkgs, config, ...}:
{
  home.file."${config.home.homeDirectory}/.mozilla/firefox/uday/chrome".source = inputs.firefox-theme;
}