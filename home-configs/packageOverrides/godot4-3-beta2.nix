{
  lib,
  godot_4,
  fetchFromGitHub,
  wayland-scanner,
  wayland,
  withWayland ? true,
}:

godot_4.overrideAttrs (oldAttrs: {
  pname = "godot4-beta";
  version = "4.3-beta2";
  src = fetchFromGitHub {
    owner = "godotengine";
    repo = "godot";
    rev = "b75f0485ba15951b87f1d9a2d8dd0fcd55e178e4";
    hash = "sha256-IVWRf29s4ig+VMl4s/kHjwjFrZEl72q7rmynhHocMIM=";
  };
  buildInputs = oldAttrs.buildInputs ++ lib.optional withWayland wayland-scanner;
  runtimeDependencies = oldAttrs.runtimeDependencies ++ lib.optional withWayland wayland;
  sconsFlags = oldAttrs.sconsFlags ++ lib.optional withWayland "wayland=true";
})
