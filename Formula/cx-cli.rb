class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix."
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.28.tgz"
  sha256 "5ec84d8c8d844298165632dbc828bf4cafbf99984324bfb6950075dcac5738ab"
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
