{ pkgs, pkgsUnstable, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;
    #package = pkgs.vscodium;
    package = pkgsUnstable.vscode;

    # https://search.nixos.org/packages?channel=23.11&from=0&size=500&sort=alpha_asc&type=packages&query=vscode-extensions
    extensions = with pkgsUnstable; [
      vscode-extensions.bbenoist.nix
      vscode-extensions.catppuccin.catppuccin-vsc
      vscode-extensions.catppuccin.catppuccin-vsc-icons
      vscode-extensions.dracula-theme.theme-dracula
      vscode-extensions.editorconfig.editorconfig
      #vscode-extensions.github.copilot
      #vscode-extensions.github.copilot-chat
      vscode-extensions.jdinhlife.gruvbox
      vscode-extensions.mvllow.rose-pine
      vscode-extensions.roman.ayu-next
    ];

    #globalSnippets = { };

    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.keybindings
    keybindings = [
    ];

    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.languageSnippets
    #userSettings = {
    #  "workbench.colorTheme" = "Gruvbox Dark Medium";
    #  "search.showLineNumbers" = true;
    #  "editor.renderWhitespace" = "boundary";
    #  "[nix]"."editor.indentSize" = 2;
    #  "[nix]"."editor.detectIndentation" = false;
    #};
  };
}
