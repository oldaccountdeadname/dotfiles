{ pkgs }:

let emacs = pkgs.emacsGcc;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company doom-themes flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [
    elpher fira-code-mode ivy swiper counsel vterm
  ]))
