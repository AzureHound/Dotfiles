{ lib, config, ... }:

{
  programs.lazygit = {
    enable = config.pixel.profiles.workstation.enable && config.programs.git.enable;

    # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#default
    settings = {
      gui = {
        authorColors.Eden = "#8bd5ca";
        branchColors = {
          "release" = "#eed49f";
          "hotfix" = "#ed8796";
          "feature" = "#a6da95";
        };

        scrollHeight = 10;
        scrollPastBottom = false;
        skipRewordInEditorWarning = true;
        sidePanelWidth = 0.22;
        expandFocusedSidePanel = true;

        theme = {
          activeBorderColor = [
            "#a6da95"
            "#b7bdf8"
            "bold"
          ];
          inactiveBorderColor = [
            "#a5adcb"
            "#5b6078"
          ];
          optionsTextColor = [ "#8aadf4" ];
          selectedLineBgColor = [ "#363a4f" ];
          cherryPickedCommitBgColor = [ "#494d64" ];
          cherryPickedCommitFgColor = [ "#b7bdf8" ];
          unstagedChangesColor = [ "#ed8796" ];
          defaultFgColor = [ "#cad3f5" ];
          searchingActiveBorderColor = [ "#eed49f" ];
        };

        showNumstatInFilesView = true;
        # showRandomTip = false;
        showCommandLog = false;
        showBottomLine = false;
        showPanelJumps = false;
        nerdFontsVersion = "3";
        showDivergenceFromBaseBranch = "arrowAndNumber";
        commandLogSize = 5;
        filterMode = "fuzzy";
        statusPanelView = "allBranchesLog";
      };

      git = {
        diffRenderers = lib.lists.singleton {
          colorArg = "always";
          command = lib.strings.escapeShellArgs [
            "delta"
            "--paging=never"
            "--dark"
            "--hyperlinks"
            "--hyperlinks-file-link-format=lazygit-edit://{path}:{line}"
          ];
        };

        autoFetch = false;
        overrideGpg = true;
        parseEmoji = true;
        branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' {{branchName}} --";
        allBranchesLogCmds = [
          "git log --graph --all --color=always --abbrev-commit  --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
        ];
      };

      update = {
        method = "never";
      };

      os = {
        # edit = "[ -z \"$NVIM\" ] && (nvim -- {{filename}}) || (nvim --server \"$NVIM\" --remote-send \"q\" && nvim --server \"$NVIM\" --remote {{filename}})";
        editPreset = "nvim-remote";
      };

      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
    };
  };
}
