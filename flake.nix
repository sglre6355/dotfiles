{
  description = "sglre6355's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      ...
    }:
    let
      username = "sglre6355";
    in
    {
      nixosConfigurations = {
        SGR-PCPA02 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/sgr-pcpa02
          ];
          specialArgs = {
            host = "SGR-PCPA02";
            inherit self username;
          };
        };
        SGR-PCPB01 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/sgr-pcpb01
          ];
          specialArgs = {
            host = "SGR-PCPB01";
            inherit self username;
          };
        };
      };

      darwinConfigurations = {
        m-stony = nix-darwin.lib.darwinSystem {
          modules = [
            ./hosts/m-stony
          ];
          specialArgs = {
            host = "m-stony";
            inherit self;
            username = "keima_hara";
          };
        };
      };
    };
}
