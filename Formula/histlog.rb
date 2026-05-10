class Histlog < Formula
  desc "Log-structured shell history with NDJSON capture and SQLite query projection"
  homepage "https://github.com/wstein/histlog"
  url "https://github.com/wstein/histlog/releases/download/v0.1.1/histlog-darwin-arm64-v0.1.1.tar.gz"
  sha256 "48dd637efe3b38b581458a8075c840d92a7eaf46b8a88b87b70725fa9a6b8dc2"
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
