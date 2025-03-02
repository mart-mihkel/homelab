{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; cudaSupport = true; }; } }:

let
  pypkgs = pkgs.python3.withPackages (p: with p; [
    scikit-learn
    torchvision
    torchaudio
    pandas
    numpy
    scipy
    torch
    tqdm
  ]);
in
pkgs.mkShell {
  buildInputs = [ pypkgs ];

  shellHook = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib
    export CUDA_HOME=/run/opengl-driver
    export CUDA_PATH=/run/opengl-driver

    echo 📦 pytorch nix-shell
    echo 🐍 python-${pkgs.python3.version}
    echo 🔥 torch-${pkgs.python3Packages.torch.version}
  '';
}
