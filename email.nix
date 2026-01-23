{
  pkgs,
  user,
  config,
  ...
}:
{
  accounts.email.maildirBasePath = "";
  accounts.email.accounts.Nexthop = {
    primary = true;
    flavor = "gmail.com";
    address = "${user.email}";
    userName = "${user.email}";
    realName = "${user.description}";
    maildir.path = "";
    lieer.enable = true;
    notmuch.enable = true;
    aerc = {
      enable = true;
      extraAccounts =
        let
          maildirBasePath = config.accounts.email.maildirBasePath;
          query-map = pkgs.writeText "query-map" ''
            Inbox=tag:inbox and not tag:archived
            Unread=tag:unread
            Drafts=tag:draft
            Sent=tag:sent
            Starred=tag:flagged
            Trash=tag:trash
            Spam=tag:spam
          '';
        in
        {
          source = "notmuch://${maildirBasePath}mail";
          check-mail = "5m";
          check-mail-cmd = "gmi sync -C ${maildirBasePath} && notmuch new";
          outgoing = "gmi send -C ${maildirBasePath} -t";
          query-map = "${query-map}";
          sent = "Sent";
        };
    };
  };

  programs = {
    gpg.enable = true;
    lieer.enable = true;
    notmuch = {
      enable = true;
      new.tags = [ ];
      search.excludeTags = [
        "trash"
        "spam"
      ];
      extraConfig = {
        database.path = "${config.accounts.email.maildirBasePath}mail";
      };
    };
    aerc = {
      enable = true;
      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
        };
        ui = {
          mouse-enabled = true;
        };
        compose = {
          address-book-cmd = "notmuch address \"%s\"";
        };
        filters = {
          "text/plain" = "colorize";
          "text/html" = "${pkgs.w3m}/bin/w3m -T text/html";
          ".headers" = "colorize";
        };
        "ui:folder=Sent" = {
          column-name = "{{index (.To | names) 0}}";
          index-columns = "flags:4,name<20%,subject,date>=";
        };
      };
      extraBinds = import ./aerc-binds.nix;
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };
  };
}
