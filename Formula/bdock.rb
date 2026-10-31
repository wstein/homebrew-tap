class Bdock < Formula
  desc "Build and manage OCI tool bundles"
  homepage "https://github.com/wstein/bundledock"
  version "0.2.0"
  license "EUPL-1.2"

  if OS.mac?
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.2.0/bdock_0.2.0_darwin_arm64.tar.gz"
    sha256 "fb1374f52981a788656b7d9342506235e06626a1430b93aa51526ab148fd0c8c"
    depends_on arch: :arm64
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.2.0/bdock_0.2.0_linux_arm64.tar.gz"
    sha256 "b03e24bc3d132e9907ce7469d7ad3b1ecfefa2c75883e620856059ed2c4b67f3"
  else
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.2.0/bdock_0.2.0_linux_amd64.tar.gz"
    sha256 "750129c7b43586b0cbf35a26de5bf233b0a5bccc1ba2bbc86c60be784cce3bf4"
  end

  def install
    bin.install "bdock"
  end

  def caveats
    <<~EOS
      `bdock tools volume` needs a running Docker. `bdock publish` runs from a
      clean clone of wstein/bundledock on main and needs a GitHub token that can
      read Actions runs and dispatch workflows (--token, GH_TOKEN, GITHUB_TOKEN
      or `gh auth token`).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bdock --version")
  end
end
