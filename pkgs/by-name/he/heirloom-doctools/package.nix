{
  stdenv,
  fetchFromGitHub,
  byacc,
  flex,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "heirloom-doctools";
  version = "191015-unstable-2024-08-11";

  src = fetchFromGitHub {
    owner = "n-t-roff";
    repo = "heirloom-doctools";
    rev = "2e9b0c67ed0f8efcf81c376e067d5256370dbc23";
    hash = "sha256-aQuvLYi8+72sK4hZSbUUcTWWfq4MDFSBl8t/K4LsXmw=";
  };

  nativeBuildInputs = [
    byacc
    flex
  ];

  postPatch = ''
    echo PREFIX=$out >> mk.config
    echo BINDIR=$out/bin >> mk.config
    echo MANDIR=$out/share/man >> mk.config
  '';

  dontAddPrefix = true;

  meta = {
    description = "troff, nroff, and related utilities to format manual pages and other documents (OpenSolaris version)";
    longDescription = ''
      The Heirloom Documentation Tools package provides troff, nroff, and related utilities to format manual pages and other documents for output on terminals and printers.
      They are portable and enhanced versions of the utilities released by Sun as part of OpenSolaris, which are a variant of ditroff, which, in turn, descends from the historical
      Unix troff that generated output for the C/A/T phototypesetter.
    '';
    homepage = "https://n-t-roff.github.io/heirloom/doctools.html";
    license = lib.licenses.cddl11;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    maintainers = with lib.maintainers; [ elfenermarcell ];
    platforms = lib.platforms.linux;
  };
}
