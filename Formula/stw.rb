class Stw < Formula
  desc "Read-only overview and stateless issue/PR tooling for GitHub workspaces"
  homepage "https://github.com/wstein/sourcesteward"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/sourcesteward/releases/download/v0.2.0/stw_0.2.0_darwin_arm64.tar.gz"
      sha256 "bf483b76c5339d104962ae1b9fa9e7fe99cbaeb2c73a0ddc161dc333715e9e07"
    else
      url "https://github.com/wstein/sourcesteward/releases/download/v0.2.0/stw_0.2.0_darwin_amd64.tar.gz"
      sha256 "0014acd6d08463ef6aeb31b891dffcc0f9e622eb9824f59a5cf567c23e8296fb"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sourcesteward/releases/download/v0.2.0/stw_0.2.0_linux_arm64.tar.gz"
    sha256 "f4cd56d7612da98fb176ffedb36de6c83ba1a54623680ddbd40aec91cf8ad75b"
  else
    url "https://github.com/wstein/sourcesteward/releases/download/v0.2.0/stw_0.2.0_linux_amd64.tar.gz"
    sha256 "5fb21024b6c1d545bc8d377597995a8b71e3bcafeea232e9f693525d09de0f1e"
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
