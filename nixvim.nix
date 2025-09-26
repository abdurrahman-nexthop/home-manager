{

  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    imports = [ inputs.neve.nixvimModule ];
    jdtls.enable = false;
    nvim-lint.enable = false;
    wakatime.enable = false;
    keymaps = [
      {
        key = "<leader>Cb";
        action = "<cmd>CMakeBuild<CR>";
        options.desc = "CMake Build";
      }
      {
        key = "<leader>Cg";
        action = "<cmd>CMakeGenerate<CR>";
        options.desc = "CMake Generate";
      }
      {
        key = "<leader>Cp";
        action = "<cmd>CMakeSelectBuildPreset<CR>";
        options.desc = "CMake Select Build Preset";
      }
      {
        key = "<leader>Ct";
        action = "<cmd>CMakeRunTest<CR>";
        options.desc = "CMake Run Test";
      }
      {
        key = "<leader>Cd";
        action = "<cmd>CMakeDebug<CR>";
        options.desc = "CMake Debug";
      }
      {
        key = "<leader>ac";
        action = "<cmd>Augment chat<CR>";
        options.desc = "Augment chat";
      }
      {
        key = "<leader>an";
        action = "<cmd>Augment chat-new<CR>";
        options.desc = "Augment chat-new";
      }
      {
        key = "<leader>at";
        action = "<cmd>Augment chat-toggle<CR>";
        options.desc = "Augment chat-toggle";
      }
    ];
    opts = {
      list = lib.mkForce false;
      colorcolumn = lib.mkForce "";
      guicursor = lib.mkForce [
        "n-v-c:block" # Normal, Visual and Command mode
        "i-ci-ve:ver25" # Insert, Command-line Insert and Visual-exclude mode
        "r-cr:hor20" # Replace and Command-line Replace mode
        "o:hor50" # Operator-pending mode
        "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" # All modes: blinking settings
        "sm:block-blinkwait175-blinkoff150-blinkon175" # Showmatch mode
      ];
    };
    plugins = {
      cmake-tools = {
        enable = true;
        settings = {
          cmake_build_directory = "out/\${variant:buildType}";
          cmake_soft_link_compile_commands = false;
          cmake_compile_commands_from_lsp = true;
          cmake_dap_configuration = {
            name = "cpp";
            type = "lldb";
            request = "launch";
            stopOnEntry = false;
            runInTerminal = true;
            console = "integratedTerminal";
          };
        };
      };
      dap-lldb = {
        enable = true;
        settings = {
          codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
        };
      };
      neotest = {
        enable = true;
        adapters = {
          ctest.enable = true;
        };
      };
      which-key = {
        enable = true;
        settings = {
          spec = [
            {
              __unkeyed-1 = "<leader>C";
              mode = "n";
              group = "+CMake";
              icon = "";
            }
            {
              __unkeyed-1 = "<leader>a";
              mode = "n";
              group = "+Augment";
            }
          ];
        };
      };
    };
    extraPlugins = [
      (import ./augment-vim.nix pkgs)
    ];
  };
}
