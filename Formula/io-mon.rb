# Generated from verified release assets by homebrew-formula.py.
class IoMon < Formula
  desc "Capture filesystem and IPC dependencies of a command"
  homepage "https://github.com/metacraft-labs/io-mon"
  url "https://github.com/metacraft-labs/io-mon/releases/download/v0.1.1/io-mon-0.1.1-darwin-aarch64.tar.gz"
  version "0.1.1"
  sha256 "0f1fad97ee4f0e3185a762aac2a21e9fe6fbff007521c54774f54ad84ff31333"
  license "Apache-2.0"

  depends_on :macos
  depends_on arch: :arm64

  # Preserve the published payload, including its ad-hoc signatures and data.
  preserve_rpath
  skip_clean "libexec"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/io-mon"
  end

  test do
    (testpath/"input.txt").write "release-input"
    (testpath/"probe.rb").write 'File.binwrite(ARGV[1], File.binread(ARGV[0]) + "-captured"); exit 7'
    shell_output("#{bin}/io-mon run --depfile #{testpath}/capture.rdep -- #{RbConfig.ruby} #{testpath}/probe.rb #{testpath}/input.txt #{testpath}/output.txt", 7)
    assert_equal "release-input-captured", (testpath/"output.txt").read
    evidence = JSON.parse(shell_output("#{bin}/io-mon inspect #{testpath}/capture.rdep --format json"))
    assert_equal "mcComplete", evidence.fetch("completeness")
    assert_equal 0, evidence.fetch("summary").fetch("eventLossCount")
  end
end
