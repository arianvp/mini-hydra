{
  description = "A very basic flake";
  inputs.nix-eval-jobs.url = "github:nix-community/nix-eval-jobs";
  inputs.webauthn-oidc = {
    url = "github:arianvp/webauthn-oidc";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nix-eval-jobs, webauthn-oidc }: {
    packages.x86_64-linux = {
      inherit (nixpkgs.legacyPackages.x86_64-linux) hello cowsay fortune;
    };
    packages.aarch64-darwin.hello = nixpkgs.legacyPackages.aarch64-darwin.hello;
    packages.aarch64-darwin.default = self.packages.aarch64-darwin.hello;

    hydraJobs = {
      external.webauthn-oidc = webauthn-oidc.defaultPackage.x86_64-linux;
      packages = self.packages.x86_64-linux;
    };
  };
}
