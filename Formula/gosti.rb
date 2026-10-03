# Generated from verified release assets by homebrew-formula.py.
class Gosti < Formula
  desc "Create and manage virtual machine guests"
  homepage "https://github.com/metacraft-labs/gosti"
  url "https://github.com/metacraft-labs/gosti/releases/download/v0.1.1/gosti-0.1.1-darwin-aarch64.tar.gz"
  version "0.1.1"
  sha256 "615b186037a5675bc894d3d8c87eed249d99197ae740bb9d6f14b49c9c746920"
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
