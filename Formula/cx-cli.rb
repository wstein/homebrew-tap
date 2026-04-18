class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix."
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.19.tgz"
  sha256 "e06be54c73fc12c4de87e3f9d165a87f6856dcb4d1d1bf57a4698f76d0916ca4"
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
