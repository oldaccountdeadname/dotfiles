{ pkgs }:

let emacs = pkgs.emacsNativeComp;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    company flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [
    calfw calfw-org doom-themes elpher fira-code-mode haskell-mode ivy
    lsp-haskell rustic nix-mode org-super-agenda swiper counsel
    visual-fill-column vterm
  ]))
