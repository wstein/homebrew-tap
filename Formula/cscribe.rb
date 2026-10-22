class Cscribe < Formula
  desc "Plain-text Zettelkasten tooling for Markdown notes"
  homepage "https://github.com/wstein/chartscribe"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/chartscribe/releases/download/v0.1.0/cscribe_0.1.0_darwin_arm64.tar.gz"
      sha256 "7554f773e247f25a90179abd6daec915e05740aa5ca624795dffadc987e603db"
    else
      url "https://github.com/wstein/chartscribe/releases/download/v0.1.0/cscribe_0.1.0_darwin_amd64.tar.gz"
      sha256 "5f7922db08d9b1ac93be769c3352fb9f970cd650ec07ca4ece9109eeedf23932"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/chartscribe/releases/download/v0.1.0/cscribe_0.1.0_linux_arm64.tar.gz"
    sha256 "a2acd240ceeaad7de1b9ecaf62c45843ced1ea65ba23c35bc9696f46bbefe4b0"
  else
    url "https://github.com/wstein/chartscribe/releases/download/v0.1.0/cscribe_0.1.0_linux_amd64.tar.gz"
    sha256 "b8941a418cec616df6d142d1008dd0bef7c8aea98c32911b724620e666a572cf"
  end

  def install
    bin.install "cscribe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cscribe version")

    (testpath/"notes").mkpath
    assert_match "0 notes", shell_output("#{bin}/cscribe validate --root #{testpath}")
  end
end
