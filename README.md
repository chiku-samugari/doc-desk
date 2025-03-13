# doc-desk
Personal digital document writing desk.

Following softwares are available:

+ pandoc
+ pandoc-crossref
+ Graphviz

The command `pandoc` is alias of following command:

    pandoc -H ${doc-template.packages.${system}.default}/template.tex -F pandoc-crossref -f markdown+east_asian_line_breaks -N

where `doc-template` is the following package:
    https://github.com/chiku-samugari/doc-template

# Usage

Prepare markdown and other resource files first.

    $ nix develop
    $ pandoc /path/to/markdown -o a.pdf
