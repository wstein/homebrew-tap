class CxCli < Formula
  desc "Deterministic context bundler built on top of Repomix"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.3.29.tgz"
  sha256 "bbf2812d3cee515458f3a5d7dd6e0efcc1c99f2ee1f84fff42817e384ac9418d"
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
