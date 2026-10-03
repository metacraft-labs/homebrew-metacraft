# Generated from verified release assets by homebrew-formula.py.
class Runquota < Formula
  desc "Host-wide resource admission and execution observations"
  homepage "https://github.com/metacraft-labs/runquota"
  url "https://github.com/metacraft-labs/runquota/releases/download/v0.1.1/runquota-0.1.1-darwin-aarch64.tar.gz"
  version "0.1.1"
  sha256 "91e64656f8c055382ae1c57c1d8a5b2f99e08d7fb7a7cd888b68a12c88088564"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  # Preserve the published payload, including its ad-hoc signatures and data.
  preserve_rpath
  skip_clean "libexec"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/runquota"
    bin.install_symlink libexec/"bin/runquotad"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/runquota --version")
    assert_match version.to_s, shell_output("#{bin}/runquotad --version")
  end
end
