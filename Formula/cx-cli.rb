class CxCli < Formula
  desc "Repository-native toolchain for live MCP workspaces, durable notes, and verifiable AI handoffs"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.7.tgz"
  sha256 "7b2e5879b2768915fb3ec95eba998e31b3e36f9cbd54e68c79f2dcaf81c20aa1"
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
