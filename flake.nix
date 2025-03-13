{
  description = "Pandoc with LaTeX (Japanese support)";

  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs-unstable }:
  let
    pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
    texlive = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full;
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.pandoc
        texlive
      ];
      shellHook = ''
        echo "Pandoc + 日本語対応LaTeX環境がセットアップされました😁"
      '';
    };

  };
}
