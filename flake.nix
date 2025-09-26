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
    neve.url = "github:redyf/neve";
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
        extraSpecialArgs = { inherit user system inputs; };
        modules = [
          ./home.nix
          inputs.catppuccin.homeModules.catppuccin
        ];
      };
    };
}
