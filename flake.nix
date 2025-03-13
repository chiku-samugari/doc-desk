{
  description = "Pandoc with LaTeX (Japanese support)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/02032da4af073d0f6110540c8677f16d4be0117f";
  inputs.doc-template.url = "github:chiku-samugari/doc-template/f65e6e795c67dc79eacba0e0b138d920c2d48cdc";

  outputs = { self, nixpkgs, doc-template }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    texlive = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full;
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.pandoc
        pkgs.haskellPackages.pandoc-crossref
        pkgs.graphviz
        texlive
        doc-template.packages.x86_64-linux.default
      ];
      shellHook = ''
        alias pandoc='pandoc -H ${doc-template.packages.x86_64-linux.default}/template.tex -F pandoc-crossref -f markdown+east_asian_line_breaks -N'
        echo "Pandoc + 日本語対応TeX環境がセットアップされました😁"
      '';
    };
  };
}
