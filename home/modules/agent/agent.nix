{ config, lib, pkgs, ...}:

{
  # In your system packages:
  environment.systemPackages = with llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    pi
  ];

}

