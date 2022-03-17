{ pkgs }:

let emacs = pkgs.emacs;
    emacsWithPackages = (pkgs.emacsPackagesFor emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    doom-themes flycheck lsp-mode magit org-superstar
  ]) ++ (with epkgs.melpaPackages; [ ccls fira-code-mode ]))
