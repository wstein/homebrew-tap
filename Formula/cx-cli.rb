class CxCli < Formula
  desc "Kernel-owned context bundler for deterministic AI handoff and verification"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.0.tgz"
  sha256 "c57c087315dba320c85cfdb7ebf2d2d527deaf057743fa366f06b994a66bc4fe"
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
