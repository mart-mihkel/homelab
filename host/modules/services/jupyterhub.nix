{ pkgs, ... }:

let
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      jupyterlab-vim = pyfinal.callPackage ../packages/jupyterlab-vim.nix { };
    };
  };

  tf-kernel = python.withPackages (p: with p; [
    scikit-learn
    tensorflow
    matplotlib
    ipykernel
    plotnine
    seaborn
    pandas
    numpy
    scipy
  ]);

  torch-kernel = python.withPackages (p: with p; [
    scikit-learn
    torchvision
    torchaudio
    matplotlib
    ipykernel
    plotnine
    seaborn
    pandas
    numpy
    scipy
    torch
  ]);
in
{
  services = {
    jupyterhub = {
      enable = true;

      extraConfig = ''
        c.Authenticator.allowed_users = { 'kubujuss' }
        c.Authenticator.admin_users = { 'kubujuss' }

        c.SystemdSpawner.environment = {
          'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',

          'LD_LIBRARY_PATH': '/run/opengl-driver/lib',
          'CUDA_HOME': '/run/opengl-driver',
          'CUDA_PATH': '/run/opengl-driver',

          'TF_CPP_MIN_LOG_LEVEL': '3',
        }
      '';

      kernels = {
        tensorflow = {
          displayName = "Tensoflow Nix";
          argv = [ "${tf-kernel.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
          logo32 = "${tf-kernel}/${tf-kernel.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${tf-kernel}/${tf-kernel.sitePackages}/ipykernel/resources/logo-64x64.png";
          language = "python";
          env = {
            TF_CPP_MIN_LOG_LEVEL = "3";
          };
        };

        torch = {
          displayName = "PyTorch Nix";
          argv = [ "${torch-kernel.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
          logo32 = "${torch-kernel}/${torch-kernel.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${torch-kernel}/${torch-kernel.sitePackages}/ipykernel/resources/logo-64x64.png";
          language = "python";
        };
      };

      jupyterlabEnv = python.withPackages (p: with p; [
        jupyterlab-widgets
        jupyterlab-vim
        jupyterlab
        jupyterhub
      ]);
    };
  };

  networking.firewall.allowedTCPPorts = [
    8000 # jupyterhub
  ];
}
