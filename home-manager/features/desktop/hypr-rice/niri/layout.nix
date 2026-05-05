{...}: {
  programs.niri.settings.layout = {
    background-color = "#ffffff";
    gaps = 16;
    center-focused-column = "never";
    preset-column-widths = [
      {proportion = 1.0 / 3.0;}
      {proportion = 1.0 / 2.0;}
      {proportion = 2.0 / 3.0;}
    ];
    default-column-width = {proportion = 0.5;};
    shadow = {
      enable = true;
      softness = 10;
      spread = 5;
      offset = {
        x = 3;
        y = 5;
      };
      color = "#000a";
    };
    border.width = 3;
  };
}
