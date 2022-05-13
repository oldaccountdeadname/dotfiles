{ pkgs }:

let emacs = pkgs.emacsGcc;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [
    acme-theme elpher fira-code-mode haskell-mode ivy swiper counsel
    visual-fill-column vterm
  ]))
