class CxCli < Formula
  desc "Kernel-owned context bundler for deterministic AI handoff and verification"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.5.tgz"
  sha256 "a13fdeef30dbb0afb66346cd0e7b4a11e39e72230589beae7a942d10c03e166e"
  license "MIT"

  depends_on "node"

  def install
    system "npm",
           "install",
           *std_npm_args(prefix: false),
           "--omit=dev",
           "--no-audit",
           "--no-fund"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/cx" => "cx"
  end

  test do
    assert_match "cx", shell_output("#{bin}/cx --help")
  end
end
