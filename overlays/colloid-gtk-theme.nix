final: prev: {
  colloid-gtk-theme = prev.colloid-gtk-theme.override {
    tweaks = [
      "nord"
      "rimless"
      "float"
    ];
  };
}
