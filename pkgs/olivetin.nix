{ lib
, fetchFromGitHub
, buildGoModule
, stdenvNoCC
, writableTmpDirAsHomeHook
, buf
, protoc-gen-go
, protoc-gen-go-grpc
, grpc-gateway
, buildNpmPackage
, installShellFiles
, versionCheckHook
}:

let
  version = "2025.3.28";
  
  src = fetchFromGitHub {
    owner = "OliveTin";
    repo = "OliveTin";
    tag = version;
    hash = "sha256-YiaYbFYBIF5Ncs8tHKzs7s3nU6Qv4/BN4G6qjXU0liY=";
  };

  gen = stdenvNoCC.mkDerivation {
    pname = "olivetin-gen";
    inherit version src;

    nativeBuildInputs = [
      writableTmpDirAsHomeHook
      buf
      protoc-gen-go
      protoc-gen-go-grpc
      grpc-gateway
    ];

    buildPhase = ''
      runHook preBuild
      pushd proto
      buf generate
      popd
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r service/gen $out
      runHook postInstall
    '';

    outputHashMode = "recursive";
    outputHash = "sha256-7WtMJhvslswFjqx6wE6k+O+PZzQW32YVtuNRFYn/1zE=";
  };

  webui = buildNpmPackage {
    pname = "olivetin-webui";
    inherit version src;

    npmDepsHash = "sha256-VxIPjpsbxEPP15cu5Wvz0qeDGXTMb2tojdry8YaHMVI=";

    sourceRoot = "${src.name}/webui.dev";

    buildPhase = ''
      runHook preBuild
      npx parcel build --public-url "."
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r dist $out
      cp -r *.png $out
      runHook postInstall
    '';
  };
in

buildGoModule {
  pname = "olivetin";
  inherit version src;

  modRoot = "service";

  vendorHash = "sha256-kaZDxCsW9+Vwc53WWc+q8UBryHvUWQSQwf9K5QCcOqs=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  __darwinAllowLocalNetworking = true;

  nativeBuildInputs = [ installShellFiles ];

  preBuild = ''
    ln -s ${gen} gen
    substituteInPlace internal/config/config.go \
      --replace-fail 'config.WebUIDir = "./webui"' 'config.WebUIDir = "${webui}"'
    substituteInPlace internal/httpservers/webuiServer_test.go \
      --replace-fail '"../webui/"' '"${webui}"'
  '';

  postInstall = ''
    installManPage ../var/manpage/OliveTin.1.gz
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgram = "${placeholder "out"}/bin/OliveTin";
  versionCheckProgramArg = "-version";
  doInstallCheck = true;

  meta = {
    description = "Gives safe and simple access to predefined shell commands from a web interface";
    homepage = "https://www.olivetin.app/";
    changelog = "https://github.com/OliveTin/OliveTin/releases/tag/${version}";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ defelo ];
    mainProgram = "OliveTin";
  };
}
