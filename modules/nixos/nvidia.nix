{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.hardware.nvidia-default;
in {
  options.hardware.nvidia-default = {
    enable = mkEnableOption "Enable NVIDIA GPU support";

    modesetting = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable modesetting for the NVIDIA driver.";
      };
    };

    powerManagement = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable NVIDIA power management (experimental).";
      };

      finegrained = mkOption {
        type = types.bool;
        default = false;
        description = "Enable fine-grained power management (experimental).";
      };
    };

    dynamicBoost = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable dynamic boost for NVIDIA GPUs.";
      };
    };

    open = mkOption {
      type = types.bool;
      default = false;
      description = "Use the open-source NVIDIA kernel module (alpha-quality).";
    };

    nvidiaSettings = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the NVIDIA settings menu.";
    };

    package = mkOption {
      type = types.package;
      default = config.boot.kernelPackages.nvidiaPackages.stable;
      description = "The NVIDIA driver package to use.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lshw
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = cfg.modesetting.enable;
      powerManagement.enable = cfg.powerManagement.enable;
      powerManagement.finegrained = cfg.powerManagement.finegrained;
      dynamicBoost.enable = cfg.dynamicBoost.enable;
      open = cfg.open;
      nvidiaSettings = cfg.nvidiaSettings;
      package = mkDefault cfg.package;
    };
  };
}