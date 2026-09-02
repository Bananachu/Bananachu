{ pkgs, ... }:

let
  updater = pkgs.writeShellApplication {
    name = "nixos-update";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gawk
      pkgs.git
      pkgs.gnugrep
      pkgs.nix
      pkgs.nixos-rebuild
    ];
    text = ''
      set -e
      FLAKE_DIR="/home/bananachu/nixos"
      cd "$FLAKE_DIR"
      echo "Mise à jour des dépendances du flake..."
      nix flake update
      echo "Ok. Ajout des fichiers à Git..."
      git add .
      echo "Ok Reconstruction du système..."
      sudo nixos-rebuild switch --flake "$FLAKE_DIR#"
      echo "Ok Enregistrement du commit..."
      GEN=$(nixos-rebuild list-generations | grep current | awk '{print $1}')
      git commit -m "Gen $GEN ($(date +'%Y-%m-%d %H:%M'))" || true
      echo "Ok MàJ terminée."
    ''; 
    };
  cleaner = pkgs.writeShellApplication {
    name = "nixos-clean";
    runtimeInputs = [ pkgs.nix pkgs.coreutils ];
    text = ''
      set -e
      echo "Suppression des anciennes generations systeme (+3)..."
      sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3

      echo "Suppression des anciennes generations utilisateur (+3)..."
      nix-env --delete-generations +3

      echo "Collecte des dechets et optimisation..."
      sudo nix-collect-garbage
      nix-store --optimise

      echo "Nettoyage termine !"
    '';
  };
in
{
  home.packages = [
    updater
    cleaner
  ];
}
