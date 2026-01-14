{ pkgs, user, ... }:
{
  accounts.email.accounts.Nexthop = {
    primary = true;
    flavor = "gmail.com";
    address = "${user.email}";
    userName = "${user.email}";
    realName = "${user.description}";
    passwordCommand = "pass email/gmail";
    lieer = {
      enable = true;
      sync.enable = true;
      settings = {
        replace_slash_with_dot = true;
      };
    };
    msmtp.enable = true;
    notmuch.enable = true;
    aerc.enable = true;
  };

  programs = {
    gpg.enable = true;
    lieer.enable = true;
    msmtp.enable = true;
    notmuch.enable = true;
    aerc = {
      enable = true;
      extraConfig = {
        general.unsafe-accounts-conf = true;
        filters = {
          "text/plain" = "colorize";
          "text/html" = "${pkgs.w3m}/bin/w3m -T text/html";
          ".headers" = "colorize";
        };
      };
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };
  };

  services = {
    lieer.enable = true;
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };
  };
}
