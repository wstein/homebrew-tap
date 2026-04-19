class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.27.tgz"
  sha256 "5b8b73c2e12cadaf96df95d636efefc71c0e2a713c2336d3bfdb18ae0c20a290"
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
    bin.install_symlink libexec/"bin/cx"
  end

  test do
    assert_match "cx", shell_output("#{bin}/cx --help")
  end
end
