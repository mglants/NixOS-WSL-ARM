{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL?ref=2405.5.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
    }:
    {
      packages.aarch64-linux.default = self.nixosConfigurations.nixos.config.system.build.tarballBuilder;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./configuration.nix
          {
            # nix.settings.nix-path = "nixpkgs=flake:NixOS/nixpkgs:nixos-wsl=flake:nix-community/NixOS-WSL";
            wsl.tarball.configPath = ./.;
          }
        ];
      };
    };
}
