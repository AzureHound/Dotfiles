{
  autoGroups = {
    leader = {
      clear = true;
    };
    position = {
      clear = true;
    };
    highlight_yank = {
      clear = true;
    };
    numtoggle = {
      clear = true;
    };
    newline_comments = {
      clear = true;
    };
    json_conceal = {
      clear = true;
    };
    env_diagnostics = {
      clear = true;
    };
    disableeslintonnodemodules = {
      clear = true;
    };
    man_pages = {
      clear = true;
    };
    spell_warp = {
      clear = true;
    };
    checktime = {
      clear = true;
    };
    mkdir = {
      clear = true;
    };
    splits = {
      clear = true;
    };
    window = {
      clear = true;
    };
    quit = {
      clear = true;
    };
    term = {
      clear = true;
    };
  };

  autoCmd = [
    # Disable leader & localleader for filetypes
    {
      event = [ "FileType" ];
      group = "leader";
      pattern = [
        "notify"
        "lspinfo"
        "toggleterm"
        "null-ls-info"
        "neo-tree-popup"
        "TelescopePrompt"
      ];
      callback.__raw = ''
        function(event)
          vim.keymap.set("n", "<leader>", "<nop>", { buffer = event.buf, desc = "" })
          vim.keymap.set("n", "<localleader>", "<nop>", { buffer = event.buf, desc = "" })
        end
      '';
    }

    # go to last loc when opening a buffer
    {
      event = "BufReadPost";
      group = "position";
      callback.__raw = ''
        function(event)
          local exclude = { "gitcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
          end
          vim.b[buf].last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
    }

    # Highlight yank
    {
      event = "TextYankPost";
      group = "highlight_yank";
      callback.__raw = "function() (vim.hl or vim.highlight).on_yank() end";
    }

    # Numtoggle
    {
      event = [
        "BufEnter"
        "FocusGained"
        "InsertLeave"
        "CmdlineLeave"
        "WinEnter"
      ];
      group = "numtoggle";
      pattern = "*";
      callback.__raw = ''
        function()
          if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
          end
        end
      '';
    }
    {
      event = [
        "BufLeave"
        "FocusLost"
        "InsertEnter"
        "CmdlineEnter"
        "WinLeave"
      ];
      group = "numtoggle";
      pattern = "*";
      callback.__raw = ''
        function()
          if vim.o.nu then
            vim.opt.relativenumber = false
            if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
              vim.cmd("redraw")
            end
          end
        end
      '';
    }

    # Disable Newline Comments
    {
      event = [ "BufEnter" ];
      group = "newline_comments";
      callback.__raw = ''function() vim.opt_local.formatoptions:remove({ "c", "r", "o" }) end'';
    }

    # Disable json Conceal
    {
      event = "FileType";
      group = "json_conceal";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      callback.__raw = "function() vim.opt_local.conceallevel = 0 end";
    }

    # Disable .env Diagnostics
    {
      event = [ "BufRead" ];
      group = "env_diagnostics";
      pattern = ".env";
      callback.__raw = "function(event) vim.diagnostic.enable(false, { bufnr = event.buf }) end";
    }

    # Disable Node_Modules Diagnostics
    {
      event = [
        "BufNewFile"
        "BufRead"
      ];
      group = "disableeslintonnodemodules";
      pattern = [
        "**/node_modules/**"
        "node_modules"
        "/node_modules/*"
      ];
      callback.__raw = "function(event) vim.diagnostic.enable(false, { bufnr = event.buf }) end";
    }

    # Close Man-Pages when opened inline
    {
      event = "FileType";
      group = "man_pages";
      pattern = "man";
      callback.__raw = "function(event) vim.bo[event.buf].buflisted = false end";
    }

    # Wrap & Spelling check in filetypes
    {
      event = "FileType";
      group = "spell_warp";
      pattern = [
        "text"
        "plaintex"
        "typst"
        "gitcommit"
        "markdown"
      ];
      callback.__raw = ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
    }

    # Reload on change
    {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      group = "checktime";
      callback.__raw = ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end
      '';
    }

    # Auto mkdir when saving file
    {
      event = "BufWritePre";
      group = "mkdir";
      callback.__raw = ''
        function(event)
          if event.match:match("^%w%w+:[\\/][\\/]") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
    }

    # Resize splits
    {
      event = "VimResized";
      group = "splits";
      callback.__raw = ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
    }

    # Auto close windows
    {
      event = [ "BufLeave" ];
      group = "window";
      callback.__raw = ''
        function(event)
          local auto_close_ft = { "notify", "lspinfo", "toggleterm", "null-ls-info", "TelescopePrompt" }
          local ft = vim.bo[event.buf].filetype
          if vim.tbl_contains(auto_close_ft, ft) then
            local winids = vim.fn.win_findbuf(event.buf)
            for _, win in pairs(winids) do
              pcall(vim.api.nvim_win_close, win, true)
            end
          end
        end
      '';
    }

    # Close filetypes with <q>
    {
      event = "FileType";
      group = "quit";
      pattern = [
        "PlenaryTestPopup"
        "checkhealth"
        "dap-float"
        "dbout"
        "gitsigns-blame"
        "grug-far"
        "help"
        "lspinfo"
        "neotest-output"
        "neotest-output-panel"
        "neotest-summary"
        "notify"
        "qf"
        "spectre_panel"
        "startuptime"
        "tsplayground"
      ];
      callback.__raw = ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.schedule(function()
            vim.keymap.set("n", "q", function()
              vim.cmd("close")
              pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
              buffer = event.buf,
              silent = true,
              desc = "Quit buffer",
            })
          end)
        end
      '';
    }

    # TERM
    {
      event = [ "TermOpen" ];
      group = "term";
      callback.__raw = ''
        function()
          vim.opt_local.listchars = ""
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.spell = false
        end
      '';
    }
  ];
}
