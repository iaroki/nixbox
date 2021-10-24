{ config, pkgs, ... }:

{
    time.timeZone = "Europe/Kiev";

    environment.systemPackages = with pkgs; [
    wget vim tmux git htop tree ripgrep unzip
    terraform_0_14 terraform-docs tflint terragrunt
    ansible ansible-lint awscli2 kubectl helm
    go python38 python38Packages.pip skopeo buildah

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
