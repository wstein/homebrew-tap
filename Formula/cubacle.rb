class Cubacle < Formula
  desc "Rubik's cube solver and generator for 2x2 to 7x7 with a REST backend"
  homepage "https://github.com/wstein/cubacle"
  license "AGPL-3.0-or-later"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/cubacle/releases/download/v0.1.0/cubacle_0.1.0_darwin_arm64.tar.gz"
      sha256 "2f0cc9f20579210fb0a529b67056339d92d433b0927c2bbca51407479166c84c"
    else
      url "https://github.com/wstein/cubacle/releases/download/v0.1.0/cubacle_0.1.0_darwin_amd64.tar.gz"
      sha256 "462d289fb93637bafcf870b8362bf38b0399f82790309bd0956a29c25f633bd2"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/cubacle/releases/download/v0.1.0/cubacle_0.1.0_linux_arm64.tar.gz"
    sha256 "5c6b57b810bd9fae33438a2784ca4e4a2cd0fd858fdc88bb0245953f7f91c84b"
  else
    url "https://github.com/wstein/cubacle/releases/download/v0.1.0/cubacle_0.1.0_linux_amd64.tar.gz"
    sha256 "0f80fc6338383490d4796e6b1163db32a871a3e30611908165175640e32f4ace"
  end

  def install
    bin.install "cubacle", "cubacle-server"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubacle --version")

    output = shell_output("#{bin}/cubacle solve --scramble \"R U R' U'\" 2>&1")
    assert_match(/^moves \d+$/, output)
  end
end
