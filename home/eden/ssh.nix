{ name, config, ... }:

let
  inherit (config.home) homeDirectory;
  inherit (config.sops) secrets;

  sshDir = "${homeDirectory}/.ssh";
in

{
  programs.ssh = {
    inherit (config.pixel.profiles.workstation) enable;
    enableDefaultConfig = false;

    # includes = [ secrets.rsync-sshconf.path ];

    settings = {
      "*" = {
        AddKeysToAgent = "no";
        ForwardAgent = false;
        HashKnownHosts = true;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        Compression = true;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
        IdentitiesOnly = true;
      };

      "aur.archlinux.org" = {
        User = "aur";
        HostName = "aur.archlinux.org";
        IdentityFile = secrets.aur.path;
      };

      "codeberg.org" = {
        User = "git";
        HostName = "codeberg.org";
        IdentityFile = secrets.codeberg.path;
      };

      "forgejo.eyeshome.duckdns.org" = {
        User = "git";
        HostName = "forgejo.eyeshome.duckdns.org";
        Port = 222;
        IdentityFile = secrets.forgejo.path;
      };

      "forgejo.softshell.duckdns.org" = {
        User = "forgejo";
        HostName = "forgejo.softshell.duckdns.org";
        IdentityFile = secrets.forgejo.path;
      };

      "github.com" = {
        User = "git";
        HostName = "github.com";
        IdentityFile = secrets.github.path;
      };

      "gitlab.com" = {
        User = "git";
        HostName = "gitlab.com";
        IdentityFile = secrets.gitlab.path;
      };

      "Legion" = {
        User = "${name}";
        HostName = "10.10.0.4";
      };

      "Zero" = {
        User = "eyes";
        HostName = "192.168.29.10";
      };
    };
  };

  home.file.".ssh/id_ed25519.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyoX1ZlGb9FFtu9Xw8GE8C+GkwExi03xHZ0LSPnD6zw
  '';

  sops.secrets = {
    aur = { };
    codeberg = { };
    forgejo = { };
    github = { };
    gitlab = { };
    nixos = { };
    # rsync.path = sshDir + "/rsync";
    # rsync-sshconf = { };
  };
}