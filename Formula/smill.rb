class Smill < Formula
  desc "Git-native cheatsheet compiler for Markdown and YAML reference sheets"
  homepage "https://github.com/wstein/sheetmill"
  license "EUPL-1.2"

  if OS.mac?
    url "https://github.com/wstein/sheetmill/releases/download/v0.1.1/smill_0.1.1_darwin_arm64.tar.gz"
    sha256 "7ea7f4dfd32144cd4ca7846d732f52d186b29b707cb65b3e684d90065fee0c24"
    depends_on arch: :arm64
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sheetmill/releases/download/v0.1.1/smill_0.1.1_linux_arm64.tar.gz"
    sha256 "fd2fb9b35f405e43c56e1e8cb413e9c1efb519e42c168aefc1d1eae03ee9268d"
  else
    url "https://github.com/wstein/sheetmill/releases/download/v0.1.1/smill_0.1.1_linux_amd64.tar.gz"
    sha256 "c50180f8220d683edf2bbbbf25cb15d81b0bc7733f5ee9e44d2d1f69805475dc"
  end

  def install
    bin.install "smill"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/smill version")

    (testpath/"sheet.md").write <<~MARKDOWN
      ---
      title: Test
      ---
      # Test

      Hello.
    MARKDOWN
    system bin/"smill", "check", testpath/"sheet.md"
  end
end
