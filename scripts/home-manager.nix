{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
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
            pkgs.ctags
            pkgs.ripgrep
            pkgs.jq
            pkgs.yq
            pkgs.tree
            pkgs.terraform_0_14
            pkgs.terraform-docs
            pkgs.tflint
            pkgs.terragrunt
            pkgs.ansible
            pkgs.ansible-lint
            pkgs.awscli2
            pkgs.kubectl
            pkgs.helm
            pkgs.go
            pkgs.gopls
            pkgs.python38
            pkgs.python38Packages.pip
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
        };

        programs.neovim = {
	    enable = true;
	    plugins = with pkgs.vimPlugins; [
                gruvbox-community
                lightline-vim
                vim-terraform
                vim-terraform-completion
                vim-hcl
                vim-nix
                vim-go
                deoplete-nvim
                fzf-vim
                tagbar
                nerdtree
                nerdtree-git-plugin
                vim-surround
                vim-commentary
                vim-fugitive
                vim-gitgutter
                rainbow
                vim-better-whitespace
                indentLine
                vim-devicons
            ];
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            extraConfig = ''
                map <C-n> :NERDTreeToggle<CR>
                nmap <C-P> :FZF<CR>
                inoremap kj <esc>
                cnoremap kj <C-C>

                colorscheme gruvbox
                set background=dark
                set number
                syntax on
                set encoding=utf-8
                set laststatus=2
                set noshowmode
                set incsearch
                set hlsearch
                set smarttab
                set expandtab
                set tabstop=2
                set shiftwidth=2
                set softtabstop=2
                set smartindent
                set ignorecase
                set smartcase
                set scrolloff=8
                set cursorline
                set splitbelow
                set splitright

                let g:indentLine_color_dark = 1
                let g:indentLine_char = '┊'
                let g:deoplete#enable_at_startup = 1
                let g:better_whitespace_enabled=1
                let g:strip_whitespace_on_save=1
                let g:rainbow_active = 1
                let g:lightline = {
                    \ 'colorscheme': 'gruvbox',
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ],
                    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                    \ },
                    \ 'component_function': {
                    \   'gitbranch': 'FugitiveHead'
                    \ },
                    \ }
            '';
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

