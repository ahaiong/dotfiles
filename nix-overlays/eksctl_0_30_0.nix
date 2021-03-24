self: super:
{
  eksctl_0_30_0  = super.eksctl.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "weaveworks";
      repo = "eksctl";
      rev = "0.30.0";
      sha256 = "0kg966czixkmaaznl7xm751jpx4252nkm99vaigg1iwhlx2yczh9";
    };
  });
}
