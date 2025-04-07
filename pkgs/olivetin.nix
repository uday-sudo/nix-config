{ pkgs }:

let
  version = "2025.3.28";
  arch = if pkgs.stdenv.hostPlatform.isx86_64 then "amd64" else "arm64";
  src = pkgs.fetchurl {
    url = "https://github.com/OliveTin/OliveTin/releases/download/${version}/OliveTin-linux-${arch}.tar.gz";
    sha256 = "KCGHAHyGgAcITYWGKf4TfI6rNUfHpt2FL9VPQH8Ty54=";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "olivetin";
  inherit version;
  inherit src;

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];

  buildInputs = [ pkgs.glibc ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp OliveTin $out/bin/
    chmod +x $out/bin/OliveTin
    
    # If there are additional files like config examples or webroot
    mkdir -p $out/share/olivetin
    cp -r webroot $out/share/olivetin/ || true
    cp -r config.yaml $out/share/olivetin/ || true
  '';

  meta = with pkgs.lib; {
    description = "OliveTin allows you to easily define and run custom commands through a web interface.";
    homepage = "https://github.com/OliveTin/OliveTin";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "uday101" ];
  };
}
