final: prev: {
  neovim = prev.neovim.override {
    extraMakeWrapperArgs =
      let
        extraPackages = with final; [
          bash-language-server
          shfmt

          dot-language-server

          haskell-language-server
          ormolu

          lua-language-server

          nixd

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
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-web-devicons
          plenary-nvim
          surround-nvim
          which-key-nvim
          yazi-nvim
        ];
        opt = [ ];
      };
    };
  };
}
