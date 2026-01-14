{ pkgs, user, ... }:
{
  accounts.email.accounts.nexthop = {
    primary = true;
    flavor = "gmail.com";
    address = "${user.email}";
    userName = "${user.email}";
    realName = "${user.description}";
    passwordCommand = "pass email/gmail";
    msmtp.enable = true;
  };

  programs = {
    gpg.enable = true;
    msmtp.enable = true;
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
