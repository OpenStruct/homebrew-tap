class MacDiskCleaner < Formula
  desc "Find and safely delete what's filling your Mac's disk (caches, Xcode, node_modules)"
  homepage "https://openstruct.github.io/mac-disk-cleaner/"
  url "https://github.com/OpenStruct/mac-disk-cleaner/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "1047271c822ba58c5c05d266395f250929e74acd76f8b4ba84b1e1a60e514407"
  license "MIT"
  head "https://github.com/OpenStruct/mac-disk-cleaner.git", branch: "main"

  depends_on :macos

  def install
    libexec.install "diskclean.py", "index.html", "static"
    # Uses the python3 from Apple's Command Line Tools, which Homebrew already requires.
    (bin/"mac-disk-cleaner").write <<~SH
      #!/bin/bash
      exec /usr/bin/python3 "#{libexec}/diskclean.py" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run `mac-disk-cleaner` to scan your home folder in the browser (http://127.0.0.1:8765).
      To include folders protected by macOS, give your terminal Full Disk Access in
      System Settings → Privacy & Security.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mac-disk-cleaner --version")
    assert_path_exists libexec/"index.html"
    assert_path_exists libexec/"static/MonaSans.woff2"
  end
end
