{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mdDoc
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.services.azerothcore-wotlk;

  user = "azerothcore-wotlk";
  group = "azerothcore-wotlk";

  authServerConfig = ''
    [authserver]
    BindIP = ${cfg.auth.bind}
    LoginDatabaseInfo = ${
      lib.concatStringsSep ";" [
        cfg.auth.db.host
        (toString cfg.auth.db.port)
        cfg.auth.db.username
        cfg.auth.db.password
        cfg.auth.db.database
      ]
    }
    LogsDir = /var/lib/azerothcore-wotlk/logs
    MySQLExecutable = ${pkgs.mariadb}/bin/mysql
    SourceDirectory = ${pkgs.azerothcore-wotlk-source}/
    TempDir = /tmp
    ${cfg.auth.config}
  '';

  worldServerConfig = ''
    [worldserver]
    BindIP = ${cfg.world.bind}
    LoginDatabaseInfo = "${
      lib.concatStringsSep ";" [
        cfg.auth.db.host
        (toString cfg.auth.db.port)
        cfg.auth.db.username
        cfg.auth.db.password
        cfg.auth.db.database
      ]
    }"
    WorldDatabaseInfo = "${
      lib.concatStringsSep ";" [
        cfg.world.db.host
        (toString cfg.world.db.port)
        cfg.world.db.username
        cfg.world.db.password
        cfg.world.db.worldDatabase
      ]
    }"
    CharacterDatabaseInfo = "${
      lib.concatStringsSep ";" [
        cfg.world.db.host
        (toString cfg.world.db.port)
        cfg.world.db.username
        cfg.world.db.password
        cfg.world.db.characterDatabase
      ]
    }"
    DataDir = ${cfg.world.dataPackage}/
    LogsDir = /var/lib/azerothcore-wotlk/logs
    MySQLExecutable = ${pkgs.mariadb}/bin/mysql
    SourceDirectory = ${pkgs.azerothcore-wotlk-source}/
    TempDir = /tmp
    CMakeCommand = ${pkgs.cmake}/bin/cmake
    ${cfg.world.config}
  '';

  moduleConfigs = lib.mapAttrs' (
    name: content:
    lib.nameValuePair "azerothcore-wotlk/modules/${name}.conf" {
      inherit user group;
      text = content;
      mode = "0644";
    }
  ) cfg.modules.config;

  pkgWithModules = cfg.package.override { modules = cfg.modules.packages; };
in
{
  options.services.azerothcore-wotlk = {
    enable = mkEnableOption "Enable the azerothcore-wotlk WoW server";

    package = mkOption {
      type = types.package;
      default = pkgs.azerothcore-wotlk-server;
      description = mdDoc "azerothcore-wotlk server package to use";
    };

    auth = {
      bind = mkOption {
        type = types.str;
        default = "0.0.0.0";
        description = mdDoc "The IP to bind the server to";
      };

      config = mkOption {
        type = types.str;
        default = "";
        description = mdDoc "Configuration put into `authserver.conf`.";
      };

      db = {
        host = mkOption {
          type = types.str;
          default = "127.0.0.1";
          description = mdDoc "Host to the MySQL database server";
        };

        port = mkOption {
          type = types.int;
          default = 3306;
          description = mdDoc "Port to the MySQL database server";
        };

        username = mkOption {
          type = types.str;
          default = "root";
          description = mdDoc "Username to login to the MySQL database server";
        };

        password = mkOption {
          type = types.str;
          default = "";
          description = mdDoc "Password to login to the MySQL database server";
        };

        database = mkOption {
          type = types.str;
          default = "acore_auth";
          description = mdDoc "Database name in the MySQL database server";
        };
      };
    };

    modules = {
      packages = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = "Modules to add to the server build. The package needs to contain a single directory with the name of the mod as it's root.";
      };

      config = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = mdDoc "configuration for each module. The attr key represent the name of the configuration file. You don't need to add `.conf` to the name.";
      };
    };

    world = {
      bind = mkOption {
        type = types.str;
        default = "0.0.0.0";
        description = mdDoc "The IP to bind the server to";
      };

      config = mkOption {
        type = types.str;
        default = "";
        description = mdDoc "Configuration put into `worldserver.conf`.";
      };

      dataPackage = mkOption {
        type = types.package;
        default = pkgs.azerothcore-wotlk-data;
        description = mdDoc "Package container the server data (can be extracted from the client)";
      };

      db = {
        host = mkOption {
          type = types.str;
          default = "127.0.0.1";
          description = mdDoc "Host to the MySQL database server";
        };

        port = mkOption {
          type = types.int;
          default = 3306;
          description = mdDoc "Port to the MySQL database server";
        };

        username = mkOption {
          type = types.str;
          default = "root";
          description = mdDoc "Username to login to the MySQL database server";
        };

        password = mkOption {
          type = types.str;
          default = "";
          description = mdDoc "Password to login to the MySQL database server";
        };

        characterDatabase = mkOption {
          type = types.str;
          default = "acore_characters";
          description = mdDoc "Character database name in the MySQL database server";
        };

        worldDatabase = mkOption {
          type = types.str;
          default = "acore_world";
          description = mdDoc "World database name in the MySQL database server";
        };
      };
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc "Open ports in the firewall for the servers.";
    };
  };

  config = mkIf cfg.enable {
    environment.etc = {
      "azerothcore-wotlk/authserver.conf" = {
        inherit user group;
        text = authServerConfig;
        mode = "0644";
      };
      "/azerothcore-wotlk/worldserver.conf" = {
        inherit user group;
        text = worldServerConfig;
        mode = "0644";
      };
    } // moduleConfigs;

    systemd.tmpfiles.settings.acore = {
      "/var/lib/azerothcore-wotlk"."d" = {
        mode = "0755";
        inherit user group;
      };
    };

    systemd.services.azerothcore-wotlk-auth = {
      description = "Azerothcore WOTLK Authentication server";

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgWithModules}/bin/authserver -c /etc/azerothcore-wotlk/authserver.conf";
        WorkingDirectory = "/var/lib/azerothcore-wotlk/";
        User = user;
        Group = group;
        UMask = "0077";
        Restart = "always";
        RestartSec = 1;
        PrivateDevices = true;
        PrivateUsers = true;
        PrivateTmp = true;
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectControlGroups = true;
        ProtectSystem = "strict";
        RemoveIPC = true;
      };

      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services.azerothcore-wotlk-world = {
      description = "Azerothcore WOTLK World server";

      environment = {
        CONFIG_DIR = "/etc/azerothcore-wotlk/";
      };

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgWithModules}/bin/worldserver -c /etc/azerothcore-wotlk/worldserver.conf";
        WorkingDirectory = "/var/lib/azerothcore-wotlk";
        User = user;
        Group = group;
        UMask = "0077";
        Restart = "always";
        RestartSec = 1;
        PrivateDevices = true;
        PrivateUsers = true;
        PrivateTmp = true;
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectControlGroups = true;
        ProtectSystem = "strict";
        RemoveIPC = true;
      };

      after = [ "network.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
    };

    users.users.${user} = {
      inherit group;
      isSystemUser = true;
    };

    users.groups.${group} = { };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      3724
      8085
    ];
  };
}
