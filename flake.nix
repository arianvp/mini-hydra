{
  description = "A very basic flake";
  inputs.nix-eval-jobs.url = "github:nix-community/nix-eval-jobs";
  outputs = { self, nixpkgs, nix-eval-jobs }: {
    packages.x86_64-linux = {
      inherit (nixpkgs.legacyPackages.x86_64-linux) hello cowsay fortune;
    };
    packages.aarch64-darwin.hello = nixpkgs.legacyPackages.aarch64-darwin.hello;
    packages.aarch64-darwin.default = self.packages.aarch64-darwin.hello;
  };
}
