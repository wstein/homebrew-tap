class CxCli < Formula
  desc "Repository-native toolchain for MCP workspaces and AI handoffs"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.8.tgz"
  sha256 "8a0a4b4d8f43acb9608eef3fa03356727c029acb5cb666c734cddfa7b3274c81"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args, "--omit=dev", "--no-audit", "--no-fund"
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cx --version")
  end
end
