{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
    imports = [
        (import "${home-manager}/nixos")
    ];

    home-manager.users.msytnyk = {
        home.packages = [
            pkgs.exa
            pkgs.bat
            pkgs.fzf
            pkgs.ripgrep
            pkgs.jq
            pkgs.yq
            pkgs.tree
            pkgs.terraform_0_14
            pkgs.terraform-docs
            pkgs.terraform-ls
            pkgs.tflint
            pkgs.terragrunt
            pkgs.ansible
            pkgs.ansible-lint
            pkgs.awscli2
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.go
            pkgs.gopls
            pkgs.gotags
            pkgs.ctags
            pkgs.nodejs
            pkgs.nodePackages.npm
            pkgs.python39
            pkgs.python39Packages.pip
            pkgs.gcc
            pkgs.skopeo
            pkgs.buildah
        ];

        home.sessionVariables = {
            LANG = "en_US.UTF-8";
            LC_CTYPE = "en_US.UTF-8";
            LC_ALL = "en_US.UTF-8";
            EDITOR = "nvim";
            PAGER = "less -FirSwX";
            MANPAGER = "less -FirSwX";
            PATH = "/home/msytnyk/.npm-packages/bin:$PATH";
            NODE_PATH = "/home/msytnyk/.npm-packages/lib/node_modules";
        };

        programs.neovim = {
            enable = true;
            plugins = with pkgs.vimPlugins; [
            ];
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
        };

        programs.bash = {
            enable = true;
            shellOptions = [];
            historyControl = [ "ignoredups" "ignorespace" ];
            shellAliases = {
                ll = "exa -l";
                ls = "exa";
                ga = "git add";
                gc = "git commit";
                gco = "git checkout";
                gcp = "git cherry-pick";
                gdiff = "git diff";
                gl = "git prettylog";
                gp = "git push";
                gs = "git status";
                gt = "git tag";
            };
        };

        programs.zsh = {
            enable = true;
            autocd = true;
            enableAutosuggestions = true;
            enableCompletion = true;
            shellAliases = {
              ll = "exa -l";
              ls = "exa";
              ga = "git add";
              gc = "git commit";
              gco = "git checkout";
              gcp = "git cherry-pick";
              gdiff = "git diff";
              gl = "git prettylog";
              gp = "git push";
              gs = "git status";
              gt = "git tag";
            };
            oh-my-zsh = {
              enable = true;
              plugins = [];
              theme = "robbyrussell";
            };
          };

        programs.gpg.enable = true;
        services.gpg-agent = {
            enable = true;
            pinentryFlavor = "tty";
            defaultCacheTtl = 31536000;
            maxCacheTtl = 31536000;
        };

        programs.git = {
            enable = true;
            userName = "Maxim Sytnyk";
            userEmail = "iaroki@protonmail.com";
            signing = {
                key = "F3456398396F1A5E";
                signByDefault = true;
            };
            aliases = {
                prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
                root = "rev-parse --show-toplevel";
            };
            extraConfig = {
                color.ui = true;
                core.askPass = "";
                credential.helper = "store";
                github.user = "iaroki";
                push.default = "tracking";
                init.defaultBranch = "main";
            };
        };

        programs.tmux = {
            enable = true;
            terminal = "xterm-256color";
            secureSocket = false;
            extraConfig = ''
                set-option -g status "on"
                set-option -g status-style bg=colour237,fg=colour223
                set-window-option -g window-status-style bg=colour214,fg=colour237
                set-window-option -g window-status-activity-style bg=colour237,fg=colour248
                set-window-option -g window-status-current-style bg=red,fg=colour237
                set-option -g pane-active-border-style fg=colour250
                set-option -g pane-border-style fg=colour237
                set-option -g message-style bg=colour239,fg=colour223
                set-option -g message-command-style bg=colour239,fg=colour223
                set-option -g display-panes-active-colour colour250
                set-option -g display-panes-colour colour237
                set-window-option -g clock-mode-colour colour109
                set-window-option -g window-status-bell-style bg=colour167,fg=colour235
                set-option -g status-justify "left"
                set-option -g status-left-style none
                set-option -g status-left-length "80"
                set-option -g status-right-style none
                set-option -g status-right-length "80"
                set-window-option -g window-status-separator ""
                set-option -g status-left "#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
                set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d | %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
                set-window-option -g window-status-current-format "#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=colour239] #I #[bg=colour214,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]"
                set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour223] #I #[bg=colour239,fg=colour223] #W #[bg=colour237,fg=colour239,noitalics]"
            '';
        };
    };
}

