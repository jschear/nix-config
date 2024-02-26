{ stdenv, fetchurl, python311, ... }:

# Adapted from https://github.com/modularml/homebrew-packages/blob/main/Formula/modular.rb
stdenv.mkDerivation rec {
  name = "modular-cli";
  version = "0.5.0";

  src = fetchurl {
    url = "https://dl.modular.com/public/installer/raw/names/modular-mac-arm64/versions/latest/modular-v${version}-macos-arm64.tar.gz";
    sha256 = "sha256-ytTDY81J5RVMMY/9+So/V153BJX2hkxAVQfCAOUTBgM=";
  };

  sourceRoot = ".";

  propagatedBuildInputs = [ python311 ];

  platforms = [ "aarch64-darwin" ];

  # Packages includes /bin, /lib, /share, etc.
  installPhase = ''
    cp -r . $out/
  '';

  meta = {
    description = "Modular CLI";
  };
}
