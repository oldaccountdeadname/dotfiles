{ pkgs }:

let emacs = pkgs.emacsGcc;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [
    acme-theme calfw calfw-org elpher fira-code-mode haskell-mode ivy
    lsp-haskell swiper counsel visual-fill-column vterm
  ]))
