{ pkgs }:

{
  godot4-3-beta2 = pkgs.callPackage ./godot4-3-beta2.nix { withWayland = true; };
}
