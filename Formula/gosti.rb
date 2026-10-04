# Generated from verified release assets by homebrew-formula.py.
class Gosti < Formula
  desc "Create and manage virtual machine guests"
  homepage "https://github.com/metacraft-labs/gosti"
  url "https://github.com/metacraft-labs/gosti/releases/download/v0.1.2/gosti-0.1.2-darwin-aarch64.tar.gz"
  version "0.1.2"
  sha256 "7fcb6c4ff67fd9dbf2b3eec65da9de6719e10c4ae7b179fe20487ccf5fc3d27c"
  license "Apache-2.0"

  depends_on :macos
  depends_on arch: :arm64

  # Preserve the published payload, including its ad-hoc signatures and data.
  preserve_rpath
  skip_clean "libexec"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/gosti"
    bin.install_symlink libexec/"bin/vm-harness"
  end

  test do
    assert_match "qemu-boot", shell_output("#{bin}/gosti backends")
    assert_match "qemu-boot", shell_output("#{bin}/vm-harness backends")
  end
end
