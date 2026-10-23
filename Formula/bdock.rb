class Bdock < Formula
  desc "Build and manage OCI tool bundles"
  homepage "https://github.com/wstein/bundledock"
  version "0.1.0"
  license "EUPL-1.2"

  if OS.mac?
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.1.0/bdock_0.1.0_darwin_arm64.tar.gz"
    sha256 "e92439b8e0e632b4fa5afcd0af361646ac1d70faa9c6caafa29ecb1a88236e4e"
    depends_on arch: :arm64
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.1.0/bdock_0.1.0_linux_arm64.tar.gz"
    sha256 "f48370470c029ba821c3602a09bd959c395e3a29b3fc24d91224c147a1ed64bd"
  else
    url "https://github.com/wstein/bundledock/releases/download/bdock/v0.1.0/bdock_0.1.0_linux_amd64.tar.gz"
    sha256 "d86feb7f1a925023b74d218877e3f7d83698a66687ed22770b778132d5271b32"
  end

  def install
    bin.install "bdock"
  end

  def caveats
    <<~EOS
      `bdock tools volume` needs a running Docker. `bdock publish` runs from a
      clean clone of wstein/bundledock on main and needs a GitHub token that can
      read Actions runs and dispatch workflows (--token, GH_TOKEN, GITHUB_TOKEN
      or `gh auth token`).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bdock --version")
  end
end
