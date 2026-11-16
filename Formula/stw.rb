class Stw < Formula
  desc "Read-only overview and stateless issue/PR tooling for GitHub workspaces"
  homepage "https://github.com/wstein/sourcesteward"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/sourcesteward/releases/download/v0.2.1/stw_0.2.1_darwin_arm64.tar.gz"
      sha256 "b80b8f61777ec27ffcd543c6b21c73eca2074ade25409cd38cf359cbfbffd92e"
    else
      url "https://github.com/wstein/sourcesteward/releases/download/v0.2.1/stw_0.2.1_darwin_amd64.tar.gz"
      sha256 "b617c17b03d9f8cd3865873bc36635acc94065405c7107e0c3de07b6a4e01de0"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sourcesteward/releases/download/v0.2.1/stw_0.2.1_linux_arm64.tar.gz"
    sha256 "1bcf09c58236085df360b7ca1994db53efe1b140b7589fb300ef6b833caa5ca9"
  else
    url "https://github.com/wstein/sourcesteward/releases/download/v0.2.1/stw_0.2.1_linux_amd64.tar.gz"
    sha256 "33ef6a3610f3d0d3c2371d7f0de780be6d02827bd893d398f47d7c699137ffce"
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
