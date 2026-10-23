class Stw < Formula
  desc "Read-only overview and stateless issue/PR tooling for GitHub workspaces"
  homepage "https://github.com/wstein/sourcesteward"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/sourcesteward/releases/download/v0.1.0/stw_0.1.0_darwin_arm64.tar.gz"
      sha256 "d1f4a43861f9bf2a14b6e246aa3036121f84488398eb153fba994478265f33e7"
    else
      url "https://github.com/wstein/sourcesteward/releases/download/v0.1.0/stw_0.1.0_darwin_amd64.tar.gz"
      sha256 "7e8afd3272de5c3bfc9109758de870d699429cc51bc07976fa24feb09be14e64"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sourcesteward/releases/download/v0.1.0/stw_0.1.0_linux_arm64.tar.gz"
    sha256 "d35fe8fb5ea3c11d914301d3bbe1ebbccd7b448d1976d96061013636f8eb743a"
  else
    url "https://github.com/wstein/sourcesteward/releases/download/v0.1.0/stw_0.1.0_linux_amd64.tar.gz"
    sha256 "067e143f01f75eb2c9a25e12a83d5d3ba4522f074dd1ff6f16f50164fe52248a"
  end

  def install
    bin.install "stw"
  end

  def caveats
    <<~EOS
      stw inspects repositories with your own tools: Git 2.46 or newer is
      required for Git repositories. Native jj repositories need jj 0.45.1+ and
      bubblewrap (Linux) or sandbox-exec (macOS).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stw version")
  end
end
