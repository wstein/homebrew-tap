class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix."
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.25.tgz"
  sha256 "b8ab9516ced56152793eeeadfdaa8de813ad302efe017676f6f30ff83e85693d"
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
