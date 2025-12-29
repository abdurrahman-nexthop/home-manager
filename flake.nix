{
  description = "My Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nix-auth.url = "github:numtide/nix-auth";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:abuibrahim/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      user = {
        description = "Abdurrahman Hussain";
        email = "abdurrahman@nexthop.ai";
        name = "abdurrahman";
      };
    in
    {
      homeConfigurations."${user.name}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            pkgs
            user
            system
            inputs
            ;
        };
        modules = [
          ./home.nix
          inputs.catppuccin.homeModules.catppuccin
        ];
      };
    };
}
