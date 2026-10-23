class Cscribe < Formula
  desc "Plain-text Zettelkasten tooling for Markdown notes"
  homepage "https://github.com/wstein/chartscribe"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/chartscribe/releases/download/v0.2.0/cscribe_0.2.0_darwin_arm64.tar.gz"
      sha256 "5cee03335c244d413cccd701f9181ff202d31774cdc13556c61f61c209f7ba29"
    else
      url "https://github.com/wstein/chartscribe/releases/download/v0.2.0/cscribe_0.2.0_darwin_amd64.tar.gz"
      sha256 "5d0d43977482ab672210ba5919f3d1bbd4751f173014c31d4cd862845bcd0438"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/chartscribe/releases/download/v0.2.0/cscribe_0.2.0_linux_arm64.tar.gz"
    sha256 "f32a2d59b8ec3a172651ef347bdff02726e3bad1fe1fe5a6a4014523b9324914"
  else
    url "https://github.com/wstein/chartscribe/releases/download/v0.2.0/cscribe_0.2.0_linux_amd64.tar.gz"
    sha256 "85cf6ee25a9b5dca29c766638f123fc733c38cc1f466c867a1f510e0e0b6eda8"
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
