{ config, pkgs, ... }:

let
  modular-cli = (pkgs.callPackage ./modules/modularCli.nix { });
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jschear";
  home.homeDirectory = "/Users/jschear";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = (with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    git
    gnupg
    gh
    alacritty
    nil
    nixpkgs-fmt
    bat
    jq
    tree
    silver-searcher
    ripgrep
    neovim
    entr
    hyperfine
    flyctl
    deno
    tealdeer
    rustup # most projects use flakes, but having a rust dev env is nice for one-off projects
  ]) ++ [
    modular-cli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".gitconfig".source = dotfiles/.gitconfig;
    ".alacritty.toml".source = dotfiles/.alacritty.toml;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jschear/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "code --wait";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    opam.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;

      # https://github.com/nix-community/nix-direnv
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      initExtra = builtins.readFile ./dotfiles/.zshrc;
      shellAliases = {
        cat = "bat";
      };
      syntaxHighlighting.enable = true;
      plugins = [
        # Pure prompt
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "v1.22.0";
            sha256 = "TR4CyBZ+KoZRs9XDmWE5lJuUXXU1J8E2Z63nt+FS+5w=";
          };
        }
      ];
    };

    fzf.enable = true;
    zoxide.enable = true;

    tmux = {
      enable = true;
      extraConfig = builtins.readFile ./dotfiles/.tmux.conf;
      terminal = "screen-256color";
    };
  };
}
