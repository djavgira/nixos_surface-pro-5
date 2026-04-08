{ config , lib , pkgs } :

{
  services.clash-meta = {
  enable = true;
  configFile = "/home/bob/.config/clash-meta/config.yaml";
  #
};
}