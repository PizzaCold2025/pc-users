{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    awscli2
    jq
    zip
    (python3.withPackages (ps: with ps; [ pip ]))
  ];
}
