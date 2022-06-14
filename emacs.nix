{ pkgs }:

let emacs = pkgs.emacsNativeComp;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [
    calfw calfw-org elpher fira-code-mode haskell-mode ivy lsp-haskell rustic
    nix-mode swiper counsel visual-fill-column vterm
  ]))
