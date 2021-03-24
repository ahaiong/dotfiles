self: super:
{
  terraform_0_13_5  = super.terraform_0_13.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.13.5";
      sha256 = "1fnydzm5h65pdy2gkq403sllx05cvpldkdzdpcy124ywljb4x9d8";
    };
  });
}
