{ lib, stdenv, fetchurl, makeWrapper, git, docker }:

stdenv.mkDerivation rec {
  pname = "container-use";
  version = "0.3.0";

  src = fetchurl {
    url = "https://github.com/dagger/container-use/releases/download/v${version}/container-use_v${version}_linux_amd64.tar.gz";
    hash = "sha256-kpYhT8EUp/+VjHSgnpXO7rfn4XsgGC0w76B3FgJKmHU=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp container-use $out/bin/
    chmod +x $out/bin/container-use
    
    # Wrap binary to ensure git and docker are in PATH
    wrapProgram $out/bin/container-use \
      --prefix PATH : ${lib.makeBinPath [ git docker ]}
    
    # Create symlink for backward compatibility
    ln -s $out/bin/container-use $out/bin/cu
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "A command-line tool for managing containers";
    homepage = "https://github.com/dagger/container-use";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "container-use";
  };
}