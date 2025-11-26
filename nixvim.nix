{ pkgs, inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    imports = [ inputs.nixvim-config.nixvimModule ];
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPlugins = [
      (import ./augment-vim.nix pkgs)
    ];
  };
}
