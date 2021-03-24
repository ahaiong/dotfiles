self: super:
{
  terraform_0_14_5  = super.terraform_0_14.overrideAttrs (old: {
  # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/networking/cluster/terraform
  # https://github.com/hashicorp/terraform/releases/tag/v0.14.5
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.14.5";
      sha256 = "0drf049zghpm3ajrn006w621s7bw5r1s8gl77nd1cj2zcw2nzn1r";
      vendorSha256 = "0z9mkilazrkpbccnkws4hcc49djdwzn0cdbgqkm9bnp9fyg3rfvs";
    };
  });
}
