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
      self.nixosConfigurations.nixos.config.system.build.tarballBuilder;

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
  };
}
