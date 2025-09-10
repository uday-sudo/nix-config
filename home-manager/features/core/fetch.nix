{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.zsh.initContent = lib.mkOrder 1500 ''
    fastfetch
  '';
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "kitty-direct";
        source = "${inputs.wallpapers}/smol/me_nobg.png";
        height = 20;
        width = 50;
        padding = {
          top = 2;
          left = 2;
          right = 2;
        };
      };

      modules = [
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "square";
        }
        {
          type = "custom";
          format = "\┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "host";
          key = " PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰍛";
          keyColor = "green";
          format = "{name}";
        }
        {
          type = "custom";
          format = "\└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "\┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "bios";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "└ └";
          keyColor = "yellow";
        }
        "break"
        {
          type = "de";
          key = " DE";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "│ └";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "\└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "\┌──────────────────Uptime / Age / DT─────────────────┐";
        }
        {
          type = "command";
          key = "  OS Age ";
          keyColor = "magenta";
          text = ''
            birth_install=$(stat -c %W /)
            current=$(date +%s)
            time_progression=$((current - birth_install))
            days_difference=$((time_progression / 86400))
            echo $days_difference days
          '';
        }
        {
          type = "uptime";
          key = "  Uptime ";
          keyColor = "magenta";
        }
        {
          type = "datetime";
          key = "  DateTime ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "\└────────────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
