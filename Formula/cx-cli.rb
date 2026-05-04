class CxCli < Formula
  desc "Repository-native toolchain for MCP workspaces and AI handoffs"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.8.tgz"
  sha256 "8a0a4b4d8f43acb9608eef3fa03356727c029acb5cb666c734cddfa7b3274c81"
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
