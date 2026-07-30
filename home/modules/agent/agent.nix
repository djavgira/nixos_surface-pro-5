{ config, lib, pkgs, ...}:

{
  inputs = {
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  # In your system packages:
  environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    pi
  ];

}
