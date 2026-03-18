class DxTools < Formula
  desc "43 developer tools in one CLI — JSON, JWT, SSH, hashing, base64, UUID & more"
  homepage "https://openstruct.github.io/dx-tools/"
  url "https://github.com/OpenStruct/dx-tools/archive/refs/tags/v3.1.0.tar.gz"
  sha256 "badc16e4f83602e5f384372708c65dc89754663d7974550aac33324a832f6d8a"
  license "MIT"
  head "https://github.com/OpenStruct/dx-tools.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/dx"
  end

  test do
    assert_match "dx", shell_output("#{bin}/dx --help")
    assert_match(/[0-9a-f]{8}-/, shell_output("#{bin}/dx uuid"))
  end
end
