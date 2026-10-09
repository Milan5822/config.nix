{
  description = "Mijn NixOS configuratie";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.laptop-01 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./hosts/laptop-01/hardware-configuration.nix
      ];
    };

    nixosConfigurations.laptop-02 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hosts/laptop-02/configuration.nix
        ./hosts/laptop-02/hardware-configuration.nix
      ];
    };

    nixosConfigurations.laptop-03 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hosts/laptop-03/configuration.nix
        ./hosts/laptop-03/hardware-configuration.nix
      ];
    };

    nixosConfigurations.laptop-04 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hosts/laptop-04/configuration.nix
        ./hosts/laptop-04/hardware-configuration.nix
      ];
    };

    nixosConfigurations.laptop-05 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hosts/laptop-05/configuration.nix
        ./hosts/laptop-05/hardware-configuration.nix
      ];
    };
  };
}
