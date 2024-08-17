{
  config,
  lib,
  pkgs,
  ...
}:
{
  # imports = [ <nixos-wsl/modules> ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.nativeSystemd = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.05";
}
