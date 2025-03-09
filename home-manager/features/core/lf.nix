{pkgs, ...}: {
  #icons file
  xdg.configFile."lf/icons".source = ./icons;

  home.packages = with pkgs; [
    pistol
    xdragon
    trash-cli #FreeDesktop.org trashcan
    wl-clipboard
  ];

  programs.lf = {
    enable = true;

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';

      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
        }}
      '';
      mkfile = ''
        ''${{
          printf "File Name: "
          read ans
          $EDITOR $ans
        }}
      '';
      chmod = ''
        ''${{
            printf "Mode Bits: "
            read ans

            for file in "$fx"
            do
              chmod $ans $file
            done

            lf -remote 'send reload'
          }}
      '';
      trash = ''
        ''${{
          files=$(printf "$fx" | tr '\n' ';')
          while [ "$files" ]; do
            # extract the substring from start of string up to delimiter.
            # this is the first "element" of the string.
            file=''${files%%;*}

            trash-put "$(basename "$file")"
            # if there's only one element left, set `files` to an empty string.
            # this causes us to exit this `while` loop.
            # else, we delete the first "element" of the string from files, and move onto the next.
            if [ "$files" = "$file" ]; then
              files='''
            else
              files="''${files#*;}"
            fi
          done
          }}
      '';
      yank-paths = ''$printf '%s' "$fx" | wl-copy'';
      yank-basename = ''&basename -a -- $fx | head -c-1 | wl-copy'';
      open = ''
        ''${{
          case $(file --mime-type "$f" -bL) in
            text/*|application/json) $EDITOR "$f";;
            video/*|image/*/application/pdf) xdg-open "$f";;
            *) xdg-open "$f";;
          esac
        }}
      '';
    };

    keybindings = {
      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      d = null;
      do = "dragon-out";
      dd = "trash";

      ";" = "open";
      x = "cut";

      m = null;
      md = "mkdir";
      mf = "mkfile";
      mc = "chmod";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";

      y = null;
      yy = "copy";
      yp = "yank-paths";
      yf = "yank-basename";

      ee = "editor-open";
      V = ''''$${pkgs.bat}/bin/bat --paging=always "$f"'';
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      ifs = "\n";
    };

    # TODO: --transfer-mode file instead of memory in case of bug fix
    # idk why but --transfer-mode file doesn't work in ghostty but works in kitty
    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi

        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --transfer-mode memory < /dev/null > /dev/tty
      '';
    in ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
