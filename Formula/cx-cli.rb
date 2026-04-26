class CxCli < Formula
  desc "Kernel-owned context bundler for deterministic AI handoff and verification"
  homepage "https://github.com/wstein/cx-cli"
  url "https://registry.npmjs.org/@wsmy/cx-cli/-/cx-cli-0.5.3.tgz"
  sha256 "21426e995430b0ebee446dc45d885da6aa131f4f245605f1f99fcbc61cffd9e9"
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
