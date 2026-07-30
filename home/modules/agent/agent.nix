{ config, lib, pkgs, ...}:

{
  environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    pi
  ];
}

