{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; cudaSupport = true; }; } }:

let
  pypkgs = pkgs.python3.withPackages (p: with p; [
    scikit-learn
    tensorflow
    pandas
    numpy
    scipy
    tqdm
  ]);
in
pkgs.mkShell {
  buildInputs = [ pypkgs ];

  shellHook = ''
    export TF_CPP_MIN_LOG_LEVEL=3

    export LD_LIBRARY_PATH=/run/opengl-driver/lib
    export CUDA_HOME=/run/opengl-driver
    export CUDA_PATH=/run/opengl-driver

    echo 📦 tensorflow nix-shell
    echo 🐍 python-${pkgs.python3.version}
    echo 🤖 tensorflow-${pkgs.python3Packages.tensorflow.version}
  '';
}
