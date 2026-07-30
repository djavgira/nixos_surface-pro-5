{ config, lib, pkgs, llm-agents, ...}:

{
  environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    pi
  ];
}

