class Crosspresent < Formula
  desc "Turn one Markdown file into a self-contained HTML presentation"
  homepage "https://github.com/OpenStruct/crosspresent"
  url "https://github.com/OpenStruct/crosspresent/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "8dbe4d66b8139439ef47fa75995df89e552f48ef1176195b420cf599041d879e"
  license "MIT"
  head "https://github.com/OpenStruct/crosspresent.git", branch: "main"

  uses_from_macos "python"

  def install
    libexec.install "crosspresent.py"
    # On macOS this uses the python3 from Apple's Command Line Tools, which Homebrew already requires.
    python = OS.mac? ? "/usr/bin/python3" : (Formula["python"].opt_bin/"python3").to_s
    (bin/"crosspresent").write <<~SH
      #!/bin/bash
      exec "#{python}" "#{libexec}/crosspresent.py" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crosspresent --version")
    (testpath/"talk.md").write "# Hello\n\n## Slide\n\nBody\n"
    system bin/"crosspresent", "build", "talk.md", "-o", "talk.html"
    assert_match "Slide", (testpath/"talk.html").read
  end
end
