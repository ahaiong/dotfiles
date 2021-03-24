self: super:
{
  terraform_0_13_4  = super.terraform_0_13.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.13.4";
      sha256 = "1yvcz14q82v9jq4b9knn6wgnhlhrsz2ncvxv4lh9y1avn56chsqc";
    };
  });
}
