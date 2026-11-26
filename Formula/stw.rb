class Stw < Formula
  desc "Git workspace inspection, change planning, and review handoffs"
  homepage "https://github.com/wstein/sourcesteward"
  license "EUPL-1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wstein/sourcesteward/releases/download/v0.6.0/stw_v0.6.0_darwin_arm64.tar.gz"
      sha256 "58921f3194c3c81cc597c914dc22cad37d43bb801c7e45db22fbbd0f244d5019"
    else
      url "https://github.com/wstein/sourcesteward/releases/download/v0.6.0/stw_v0.6.0_darwin_x86_64.tar.gz"
      sha256 "a58f982e2c196af2354022c64840bc026570cb6bf2c37d81303fc2561d328fab"
    end
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/sourcesteward/releases/download/v0.6.0/stw_v0.6.0_linux_arm64.tar.gz"
    sha256 "0624aa23b86d43453b7c92e772b4fc1c4403ba133b54684faa77a9753be65031"
  else
    url "https://github.com/wstein/sourcesteward/releases/download/v0.6.0/stw_v0.6.0_linux_x86_64.tar.gz"
    sha256 "563784d5fdb6e3615151d5279f9be60c845a6400ee9e3ce6be95f0a5487aa884"
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
