class Stw < Formula
  desc "Git workspace inspection, change planning, and review handoffs"
  homepage "https://github.com/wstein/sourcesteward"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/sourcesteward/releases/download/v0.5.0/stw_v0.5.0_darwin_arm64.tar.gz"
      sha256 "1e8c8895eb642dfb11d47ad1691dbcc55838dc5dc9ff7440199c3f4b790a8db1"
    else
      url "https://github.com/wstein/sourcesteward/releases/download/v0.5.0/stw_v0.5.0_darwin_x86_64.tar.gz"
      sha256 "af5148536b1fe24654ea5b98e33db3cc0db0379cd218dc37a69289da52397d6b"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sourcesteward/releases/download/v0.5.0/stw_v0.5.0_linux_arm64.tar.gz"
    sha256 "3018aab0b368eed33d12c0d3977f5818c2c1edb9ba1c70597a3bf12fff9f8ad9"
  else
    url "https://github.com/wstein/sourcesteward/releases/download/v0.5.0/stw_v0.5.0_linux_x86_64.tar.gz"
    sha256 "aeade263946bf77d7c4b32551638e2c262cfd08c09f1f83a520a679958b096da"
  end

  def install
    bin.install "stw"
    pkgshare.install "LICENSE", "LICENSE-git-absorb-BSD-3"
  end

  def caveats
    <<~EOS
      SourceSteward is experimental. Write operations such as absorb --apply
      can rewrite Git history. Review the plan before applying it.
    EOS
  end

  test do
    assert_equal "stw #{version}", shell_output("#{bin}/stw --version").strip
    system "git", "init", "--quiet", "--initial-branch=main", testpath
    assert_match "main", shell_output("#{bin}/stw status --root . --offline")
  end
end
