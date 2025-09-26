{ pkgs, ... }:
pkgs.vimUtils.buildVimPlugin {
  name = "augment";
  postInstall = ''
    substituteInPlace $out/autoload/augment/client.vim \
      --replace-fail "let s:node_command = 'node'" \
      "let s:node_command = '${pkgs.nodejs}/bin/node'"
  '';
  src = pkgs.fetchgit {
    url = "https://github.com/augmentcode/augment.vim";
    rev = "97418c9dfc1918fa9bdd23863ea3d2e49130727f";
    hash = "sha256-ekexQ2tI/GxEbNHhxF0fj0vwIH3+H0joSayL9vmlBOs=";
  };
}
