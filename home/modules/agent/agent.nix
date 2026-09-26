{ config, lib, pkgs, llm-agents, ...}:

let
  llmPkgs = llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = [
    llmPkgs.pi
    # pi 的 npm: 扩展需要 npm/npx（pi install / pi update、context-mode 的 MCP 服务等）
    pkgs.nodejs
  ];
}
