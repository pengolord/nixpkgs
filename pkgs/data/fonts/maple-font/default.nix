{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3Packages,
  installFonts,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "maple-mono";
  version = "7.9";

  src = fetchFromGitHub {
    owner = "subframe7536";
    repo = "maple-font";
    rev = "v${finalAttrs.version}";
    hash = "sha256-wsaE54TeI2EI9VO9Q7Czv9soScGomYIfrllhQQHey2E=";
  };

  outputs = [
    "out"
    "webfont"
  ];

  nativeBuildInputs = [
    python3Packages.foundrytools-cli
    installFonts
  ];

  buildPhase = ''
    runHook preBuild

    python build.py --cn-both --hinted
    python build.py --cn-both --no-hinted --cache
    cd fonts
    rm -r TTF

    runHook postBuild
  '';

  meta = {
    homepage = "https://github.com/subframe7536/maple-font";
    description = ''
      An open source monospace font focused on smoothing your coding flow.
    '';
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ oluceps ];
  };
})
