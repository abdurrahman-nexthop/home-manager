{
  config,
  pkgs,
  user,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "${user.description}";
      user.email = "${user.email}";
      init.defaultBranch = "main";
      sendemail.confirm = "auto";
      credential = builtins.listToAttrs (
        map (
          host:
          pkgs.lib.nameValuePair host {
            username = "${user.name}-nexthop";
          }
        ) config.programs.gh.gitCredentialHelper.hosts
      );
    };
  };
}
