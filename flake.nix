{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl }: {
    packages.aarch64-linux.default =
      self.nixosConfigurations.nixos.config.system.build.tarballBuilder;

    packages.x86_64-linux.default =
      self.nixosConfigurations.nixos-x86_64.config.system.build.tarballBuilder;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          wsl.enable = true;
          system.stateVersion = "24.11";
        }
      ];
    };

    nixosConfigurations.nixos-x86_64 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          nixpkgs.config.allowUnsupportedSystem = true;
          nixpkgs.hostPlatform.system = "aarch64-linux";
          nixpkgs.buildPlatform.system = "x86_64-linux";
        }
        {
          wsl.enable = true;
          system.stateVersion = "24.11";
        }
      ];
    };
  };
}
