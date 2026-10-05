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
        let
          pkgs = import nixpkgs-home {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            host
            nixvim.homeModules.nixvim
          ];

          extraSpecialArgs = {
            inherit (pkgs.stdenv) hostPlatform;
            llmAgentsPkgs = llm-agents.packages.${system};
          };
        };
    in
    {
      nixosConfigurations = {
        SGR-PCPA02 = nixpkgs-system.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/sgr-pcpa02/system.nix
          ];
          specialArgs = {
            host = "SGR-PCPA02";
            inherit self username;
          };
        };
        SGR-PCPB01 = nixpkgs-system.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/sgr-pcpb01/system.nix
          ];
          specialArgs = {
            host = "SGR-PCPB01";
            inherit self username;
          };
        };
      };

      homeConfigurations = {
        "sglre6355@SGR-PCPA02" = mkHome {
          system = "x86_64-linux";
          host = ./hosts/sgr-pcpa02/home.nix;
        };

        "sglre6355@SGR-PCPB01" = mkHome {
          system = "x86_64-linux";
          host = ./hosts/sgr-pcpb01/home.nix;
        };
      };
    };
}
