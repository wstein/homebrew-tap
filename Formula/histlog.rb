class Histlog < Formula
  desc "Log-structured shell history with NDJSON capture and SQLite query projection"
  homepage "https://github.com/wstein/histlog"
  url "https://github.com/wstein/histlog/releases/download/v0.1.0/histlog-darwin-arm64-v0.1.0.tar.gz"
  sha256 "cf9e98b0af2269aa5130ec1c562649e908967206f2ac8d9bc310b68a7e934dcf"
  license "MIT"

  depends_on "elixir"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"histlog" => "histlog"
  end

  test do
    assert_match "histlog", shell_output("#{bin}/histlog --help")
    system "#{bin}/histlog", "consolidate", "--root", testpath/"histlog-root", "--date", "2026-05-07"
    system "#{bin}/histlog", "verify", "--root", testpath/"histlog-root", "--date", "2026-05-07"
  end
end
