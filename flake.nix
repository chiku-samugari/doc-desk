{
  description = "Pandoc with LaTeX (Japanese support)";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/02032da4af073d0f6110540c8677f16d4be0117f";
    doc-template.url = "github:chiku-samugari/doc-template/main";
  };

  outputs = { self, flake-utils, nixpkgs, doc-template }:
  flake-utils.lib.eachDefaultSystem (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      texlive = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full;
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.pandoc
          pkgs.haskellPackages.pandoc-crossref
          pkgs.graphviz
          texlive
          doc-template.packages.${system}.default
        ];

        shellHook = ''
          alias pandoc='pandoc -H ${doc-template.packages.${system}.default}/template.tex -F pandoc-crossref -f markdown+east_asian_line_breaks -N'
          echo "Pandoc + 日本語対応TeX環境がセットアップされました😁"
        '';
      };
    }
  );
}
