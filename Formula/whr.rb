class Whr < Formula
  desc "Self-hosted development workspaces with devcontainer-native tooling"
  homepage "https://github.com/wstein/workharbor"
  license "EUPL-1.2"

  if OS.mac?
    url "https://github.com/wstein/workharbor/releases/download/v0.2.0/whr_0.2.0_darwin_arm64.tar.gz"
    sha256 "6458b1bf83095a989941b7f23dc61e06d07ee771c7f76f1373dd97d561c7b07d"
    depends_on arch: :arm64
  elsif Hardware::CPU.arm?
    url "https://github.com/wstein/workharbor/releases/download/v0.2.0/whr_0.2.0_linux_arm64.tar.gz"
    sha256 "b0f8bcd408d8b123014896345dfff2ac8472e24dc479de6f49cec8f275ae36bf"
  else
    url "https://github.com/wstein/workharbor/releases/download/v0.2.0/whr_0.2.0_linux_amd64.tar.gz"
    sha256 "791105a1804239c3567c082c516229d4ff5422c9f0cfb7fa40d7900d72f0fd83"
  end

  def install
    bin.install "whr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/whr version")
  end
end
