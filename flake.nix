{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rs-python = pkgs.python312.withPackages (
          ps: with ps; [
            numpy
            keras
            tensorflow
            tensorflow-datasets
            matplotlib
            ipywidgets

            notebook
            ipykernel
          ]
        );
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            rs-python
            jupyter-all
          ];
        };
      }
    );
}
