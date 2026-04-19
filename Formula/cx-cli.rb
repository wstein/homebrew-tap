class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix."
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.24.tgz"
  sha256 "15069802c147d5e08c493b380bc2df7c89411dad6504dbdbfc10374a3c0595d2"
  license "MIT"

  depends_on "node"

  def install
    system "npm",
           "install",
           "--omit=dev",
           "--no-audit",
           "--no-fund",
           "--prefix=#{libexec}",
           buildpath
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "cx", shell_output("#{bin}/cx --help")
  end
end
