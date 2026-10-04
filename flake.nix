{
  description = "sglre6355's Nix configuration";

  inputs = {
    nixpkgs-system.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-system";
    };

    nixpkgs-home.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-home";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs-system,
      nix-darwin,
      nixpkgs-home,
      home-manager,
      llm-agents,
      nixvim,
      ...
    }:
    let
      username = "sglre6355";

      mkHome =
        { system, host }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-home {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            host
            nixvim.homeModules.nixvim
          ];

          extraSpecialArgs = {
            llmAgentsPkgs = llm-agents.packages.${system};
          };
        };
    in
    {
      nixosConfigurations = {
        SGR-PCPA02 = nixpkgs-system.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/hosts/sgr-pcpa02
          ];
          specialArgs = {
            host = "SGR-PCPA02";
            inherit self username;
          };
        };
        SGR-PCPB01 = nixpkgs-system.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/hosts/sgr-pcpb01
          ];
          specialArgs = {
            host = "SGR-PCPB01";
            inherit self username;
          };
        };
      };

      darwinConfigurations = {
        intern595noMacBook-Pro = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/hosts/intern595noMacBook-Pro
          ];
          specialArgs = {
            host = "intern595noMacBook-Pro";
            inherit self;
            username = "intern595";
          };
        };
        m-stony = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/hosts/m-stony
          ];
          specialArgs = {
            host = "m-stony";
            inherit self;
            username = "keima_hara";
          };
        };
      };

      homeConfigurations = {
        "sglre6355@SGR-PCPA02" = mkHome {
          system = "x86_64-linux";
          host = ./home/hosts/sgr-pcpa02.nix;
        };

        "sglre6355@SGR-PCPB01" = mkHome {
          system = "x86_64-linux";
          host = ./home/hosts/sgr-pcpb01.nix;
        };

        "intern595@intern595noMacBook-Pro" = mkHome {
          system = "aarch64-darwin";
          host = ./home/hosts/intern595noMacBook-Pro.nix;
        };

        "keima_hara@m-stony" = mkHome {
          system = "aarch64-darwin";
          host = ./home/hosts/m-stony.nix;
        };
      };
    };
}
