self: super:
{
  terraform_0_13_0  = super.terraform_0_13.overrideAttrs (old: {
  # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/networking/cluster/terraform
  # https://github.com/hashicorp/terraform/releases/tag/v0.13.0
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.13.0";
      sha256 = "0kangddd99ix50w67hi0pwa9js9c0hjxqvrc0lxaa6msjvjsxyyq";
    };
  });
}
