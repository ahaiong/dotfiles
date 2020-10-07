self: super:
{
  terraform_0_13_3  = super.terraform_0_13.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.13.3";
      sha256 = "1bjgsabkyh3xf4gdp41mwhw6bpmjg45bnq2hk522glk02n2xngpw";
    };
  });
}
