{ config, pkgs, ... }:

{
    imports = [ ./home-manager.nix ];

    time.timeZone = "Europe/Kiev";

    environment.systemPackages = with pkgs; [
    wget vim tmux git htop tree unzip
    ];

    environment.homeBinInPath = true;
    programs.vim.defaultEditor = true;

    users.users.msytnyk = {
        isNormalUser = true;
        createHome = true;
        home = "/home/msytnyk";
        extraGroups = [ "wheel" "docker" ];
    };

    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    nixpkgs.config.allowUnfree = true;
}
