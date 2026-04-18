class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix."
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.20.tgz"
  sha256 "98fdde999810827afe43685762ac1af07f538da5303f5aba013c50c47dd27881"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "cx", shell_output("#{bin}/cx --help")
  end
end
