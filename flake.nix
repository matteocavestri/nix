{
  description = "Matteo Cavestri NixOS config and personal dotfiles";

  outputs = { nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, stylix, self, ... }@inputs: 
    let
# -------------------- SYSTEM SETTINGS ------------------------------
      systemSettings = {
        system = "x86_64-linux"; # Your arch 
        hostname = "nixos-t2"; # Your hostname (fix scripts)
        timezone = "Europe/Rome"; # Timezone config
        locale = "it_IT.UTF-8"; # Locale config
        keymap = "it"; # Global keymap (Fix hyprland)
        profile = "personal"; # only personal
        hardware = "mbp-16-2";
        nixhw ="apple-t2"; # TODO
      };
# -------------------- USER SETTINGS --------------------------------
      userSettings = {
        username = "matteocavestri"; # Your username (fix-scripts)
        name = "Matteo Cavestri"; # For git config
        email = "matteo.cavestri@protonmail.ch"; # For git config
        wm = "hyprland"; # gnome / hyprland / cinnamon
        wmType = "wayland";
        theme = "everforest"; # See ./themes
        font = "Inconsolata Nerd Font"; # Your font name
        fontPkg = pkgs.inconsolata-nerdfont; # Your font package
        cursor = "catppuccin-mocha-dark-cursors"; # Your cursor theme name 
        cursorPkg = pkgs.catppuccin-cursors.mochaDark; # Your cursor theme package
        icons = "Papirus";
        iconsPkg = pkgs.papirus-icon-theme;
        term = "alacritty"; # Your default term (fix hyprland)
        browser = "firefox"; # TODO
        dotfilesDir = ".dotfiles";
        editor = "nvim";
      };
# -------------------------------------------------------------------
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { system = systemSettings.system; };
      pkgs-unstable = import nixpkgs-unstable { system = systemSettings.system; };
    in {
# -------------------- NixOS Configuration --------------------------
    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.${systemSettings.nixhw}
          inputs.stylix.nixosModules.stylix
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
          inherit pkgs-unstable;
        };
      };
    };
# ------------------- Home Manager Configuration ---------------------
    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          inputs.stylix.homeManagerModules.stylix
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
	      ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit systemSettings;
          inherit inputs;
          inherit pkgs-unstable;
        };
      };
    };
  };

# ---------------------- Inputs -------------------------------------
  inputs = {
# ------------------ NixOS Hardware ---------------------------------
    nixos-hardware.url = "github:nixos/nixos-hardware";
# ------------------ NixPkgs ----------------------------------------
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nurpkgs.url = "github:nix-community/NUR";

# ------------------ Home Manager -----------------------------------
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

# ------------------ Hyprland ---------------------------------------
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    }; 
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins/3ae670253a5a3ae1e3a3104fb732a8c990a31487";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hycov.url = "github:DreamMaoMao/hycov/de15cdd6bf2e46cbc69735307f340b57e2ce3dd0";
    hycov.inputs.hyprland.follows = "hyprland";
    hyprgrass.url = "github:horriblename/hyprgrass/736119f828eecaed2deaae1d6ff1f50d6dabaaba";
    hyprgrass.inputs.hyprland.follows = "hyprland";
# ------------------ Pyprland ----------------------------------------
    pyprland.url = "github:hyprland-community/pyprland";

# ------------------ Stylix ------------------------------------------
    stylix.url = "github:danth/stylix";

# ------------------ Firefox Addons ----------------------------------
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

# ------------------ Nixvim ------------------------------------------
    nixvim.url = "github:nix-community/nixvim";
# ------------------ Neve --------------------------------------------
    neve.url = "github:matteocavestri/Neve";
  };

# -------------------- NixOS Config ---------------------------------
  nixConfig = {
    extra-substituters = [
      # "https://hydra.soopy.moe"
      "https://cache.soopy.moe" # toggle these if this one doesn't work.
    ];
    extra-trusted-public-keys =
      [ "hydra.soopy.moe:IZ/bZ1XO3IfGtq66g+C85fxU/61tgXLaJ2MlcGGXU8Q=" ];
  };
}
