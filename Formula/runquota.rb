# Generated from verified release assets by homebrew-formula.py.
class Runquota < Formula
  desc "Host-wide resource admission and execution observations"
  homepage "https://github.com/metacraft-labs/runquota"
  url "https://github.com/metacraft-labs/runquota/releases/download/v0.1.3/runquota-0.1.3-darwin-aarch64.tar.gz"
  version "0.1.3"
  sha256 "c99b476eb84e9cccca9a8e527956ac463842aa632c7bb1cfa7edff3771d2fddb"
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
