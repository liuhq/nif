final: prev: {
  neovim = prev.neovim.override {
    extraMakeWrapperArgs =
      let
        extraPackages = with final; [
          bash-language-server
          shfmt
          shellcheck

          dot-language-server

          lua-language-server

          nixd
          nixfmt

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
      ## TODO: next version will be fixed
      customLuaRC = "vim.cmd [[runtime init.lua]]";
      packages.bynix = with final.vimPlugins; {
        ## Get LSP completions
        # packages.bynix = with pkgs.vimPlugins; {
        start = [
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
          nvim-treesitter-legacy.withAllGrammars
          nvim-treesitter-textobjects-legacy
          nvim-ts-autotag
          nvim-web-devicons
          oil-nvim
          plenary-nvim
          rustaceanvim
          which-key-nvim
        ];
        opt = [ ];
      };
    };
  };
}
