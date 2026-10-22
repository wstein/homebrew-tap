class Whr < Formula
  desc "Self-hosted development workspaces with devcontainer-native tooling"
  homepage "https://github.com/wstein/workharbor"
  license "EUPL-1.2"

  if OS.mac?
    url "https://github.com/wstein/workharbor/releases/download/v0.1.0/whr_0.1.0_darwin_arm64.tar.gz"
    sha256 "e97074b75b4aa715db60f76b896f43b1f5975703c3d1158fca9c5cf37df2a18a"
    depends_on arch: :arm64
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/workharbor/releases/download/v0.1.0/whr_0.1.0_linux_arm64.tar.gz"
    sha256 "42930ee6e41349facc49921e0b51667cbcb737a5d9ef3488544d6c1e5ec2be2a"
  else
    url "https://github.com/wstein/workharbor/releases/download/v0.1.0/whr_0.1.0_linux_amd64.tar.gz"
    sha256 "5bbbf4950b22154332d67e7a3bc7187d959aabb3ea6e702a6516c66882e5ff64"
  end

  def install
    bin.install "whr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/whr version")
  end
end
