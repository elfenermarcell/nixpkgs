{
  stdenv,
  fetchurl,
  cmake,
  pkg-config,
  gtk2,
  libzip,
  minixml,
  inkscape,
  freeimage,
  pandoc,
  makeWrapper,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "xtrkcad";
  version = "5.3.0";

  src = fetchurl {
    url = "https://downloads.sourceforge.net/project/xtrkcad-fork/XTrackCad/Version%20${version}/xtrkcad-source-${version}GA.tar.bz2";
    hash = "sha256-DWx8JBVetEzI0RPW1CmQqCi1LwwdkM9H2qEkxRLHUxc=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    gtk2
    libzip
    minixml
    inkscape
    freeimage
    makeWrapper
    pandoc
  ];

  outputs = [
    "out"
    "doc"
  ];

  postFixup = ''
    mkdir -p $doc/share/doc/
    mv $out/share/xtrkcad/{CHANGELOG.txt,COPYING,Readme.txt,html} $doc/share/doc/

    mv $out/share/xtrkcad/applications $out/share/
    mkdir -p $out/share/icons/hicolor/256x256/apps/
    mv $out/share/xtrkcad/logo.bmp $out/share/icons/hicolor/256x256/apps/

    rm $out/share/xtrkcad/{xdg-open,xtrkcad-setup}

    wrapProgram $out/bin/xtrkcad \
      --set XTRKCADLIB $out/share/xtrkcad/
  '';

  meta = {
    description = "CAD program for designing model railroad layouts";
    longDescription = ''
      XTrackCAD is a open-source, free, CAD program for designing model railroad layouts.
      You can easily create layout of any scale or size.
      Libraries for many brands, scales and gauges of track and turnouts/points and model structures are included.
      Adding new components is easy with the built-in editor.
      It runs on Windows, Mac and Linux.
    '';
    homepage = "https://sourceforge.net/projects/xtrkcad-fork/";
    downloadPage = "https://sourceforge.net/projects/xtrkcad-fork/files/XTrackCad/Version%20${version}/";
    license = lib.licenses.gpl2;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    maintainers = with lib.maintainers; [ elfenermarcell ];
    mainProgram = "xtrkcad";
    platforms = lib.platforms.linux;
  };
}
