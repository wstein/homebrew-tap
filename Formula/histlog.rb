class Histlog < Formula
  desc "Log-structured shell history with NDJSON capture and SQLite query projection"
  homepage "https://github.com/wstein/histlog"
  url "https://github.com/wstein/histlog/releases/download/v0.1.0/histlog-darwin-arm64-v0.1.0.tar.gz"
  sha256 "e6204c37f0d615248d40670c1312e720f5e645f74d2033765c37fd4ae6a22a12"
  license "MIT"

  depends_on "elixir"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"histlog" => "histlog"
  end

  test do
    assert_match "histlog", shell_output("#{bin}/histlog --help")
    system "#{bin}/histlog", "sync", "--root", testpath/"histlog-root", "--date", "2026-05-07"
    system "#{bin}/histlog", "info", "zsh", "--root", testpath/"histlog-root"
    system "#{bin}/histlog", "doctor", "zsh", "--root", testpath/"histlog-root", "--date", "2026-05-07"
  end
end
