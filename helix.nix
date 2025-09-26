{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        color-modes = true;
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
      {
        name = "c";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
      }
      {
        name = "cpp";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
      }
      {
        name = "protobuf";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
      }
      {
        name = "rust";
        auto-format = true;
        formatter.command = "${pkgs.rustfmt}/bin/rustfmt";
      }
    ];
  };
}
