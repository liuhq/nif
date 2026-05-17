final: prev: {
  neovim = prev.neovim.override {
    extraMakeWrapperArgs =
      let
        extraPackages = with final; [
          bash-language-server
          shfmt
          shellcheck

          dot-language-server

          vscode-json-languageserver

          lua-language-server

          nixd
          nixfmt

          rumdl

          taplo

          yaml-language-server
          yamlfmt
        ];
      in
      "--suffix PATH : '${final.lib.makeBinPath extraPackages}'";
    withPython3 = false;
    withNodeJs = false;
    withRuby = false;
    vimAlias = false;
    viAlias = true;
    configure = {
      ## TODO: wait to be fixed
      customLuaRC = "vim.cmd [[runtime init.lua]]";
      packages.bynix = with final.vimPlugins; {
        ## Get LSP completions
        # packages.bynix = with pkgs.vimPlugins; {
        start = [
          catppuccin-nvim

          blink-cmp
          bufferline-nvim
          conform-nvim
          fidget-nvim
          flash-nvim
          fzf-lua
          gitsigns-nvim
          mini-ai
          mini-bufremove
          mini-indentscope
          nui-nvim
          nvim-autopairs
          nvim-dap
          nvim-dap-view
          nvim-lspconfig
          nvim-surround

          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects

          nvim-ts-autotag
          nvim-web-devicons
          oil-nvim
          plenary-nvim
          rustaceanvim
          which-key-nvim
        ];
        # ++ builtins.attrValues nvim-treesitter-parsers;
        opt = [ ];
      };
    };
  };
}
