self: super:
{
  terraform_0_13_0  = super.terraform_0_13.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "0.13.0";
      sha256 = "0kangddd99ix50w67hi0pwa9js9c0hjxqvrc0lxaa6msjvjsxyyq";
    };
  });
}
