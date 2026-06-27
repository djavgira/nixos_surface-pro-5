{ config , lib , pkgs , ...} :

{
  services.mihomo = {
  enable = true;
  configFile = "/home/bob/.config/mihomo/config.yaml";
  #
};
}
