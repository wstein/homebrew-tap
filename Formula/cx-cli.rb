class CxCli < Formula
  desc "Kernel-owned context bundler for deterministic AI handoff and verification"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.4.0.tgz"
  sha256 "84f1878a172c8ad00c311311845e1e9ecd59aa7159a314622e47b2e2caf24704"
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
