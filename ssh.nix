{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "10.250.*" = {
        user = "admin";
        hashKnownHosts = false;
        extraOptions = {
          StrictHostKeyChecking = "no";
          ConnectTimeout = "2";
          UserKnownHostsFile = "/dev/null";
        };
      };
    };
  };
}
