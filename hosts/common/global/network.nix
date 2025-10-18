{
  inputs,
  lib,
  config,
  ...
}: {
  networking = {
    hostName = lib.mkDefault "nixos";

    firewall = {
      enable = lib.mkDefault false;
      allowPing = lib.mkDefault true;
    };

    networkmanager.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
    # interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  };

  services.tailscale.enable = lib.mkDefault true;

  services.openssh = {
    allowSFTP = lib.mkDefault true;
    enable = lib.mkDefault true;
    ports = lib.mkDefault [22 8022];
    settings = {
      PasswordAuthentication = lib.mkDefault true;
      UseDns = lib.mkDefault true;
      X11Forwarding = lib.mkDefault false;
      PermitRootLogin = lib.mkDefault "yes";
    };
  };

  security.pki.certificates = [
    ''
      =========
      -----BEGIN CERTIFICATE-----
      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
      Qg==
      -----END CERTIFICATE-----
    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIBozCCAUmgAwIBAgIQFIKNb6iVwTwcD/1tRm66DDAKBggqhkjOPQQDAjAwMS4w
      LAYDVQQDEyVDYWRkeSBMb2NhbCBBdXRob3JpdHkgLSAyMDI1IEVDQyBSb290MB4X
      DTI1MDUyNTEyNTE1MFoXDTM1MDQwMzEyNTE1MFowMDEuMCwGA1UEAxMlQ2FkZHkg
      TG9jYWwgQXV0aG9yaXR5IC0gMjAyNSBFQ0MgUm9vdDBZMBMGByqGSM49AgEGCCqG
      SM49AwEHA0IABKW0trVuuml9GD5Fg4jv+SrZKzOcGKWgSb8gJQfPe2x8ksBqhDZI
      8aRNw78kodwPVmWBj46WHQdD4NIPFVNVUsGjRTBDMA4GA1UdDwEB/wQEAwIBBjAS
      BgNVHRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBRbZiKqOzBMR1Cc3lQ1lUBPW0NT
      BjAKBggqhkjOPQQDAgNIADBFAiALoUA7xhIa89uhL6Ow+8ebyRQoMW0KniGfK7nD
      J9i3nAIhALgROVziigbzIHA7LFqn0pds6hql2CNMjvjPwK0TgKoe
      -----END CERTIFICATE-----
    ''
  ];
}
