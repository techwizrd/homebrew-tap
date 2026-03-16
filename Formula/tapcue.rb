class Tapcue < Formula
  desc "Desktop notifications for TAP/JSON test runs"
  homepage "https://github.com/techwizrd/tapcue"
  url "https://github.com/techwizrd/tapcue/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3d78f36398bf78ac52cea77dd22e6ca3d0f25ab1d31d8069488f1fd2bc892f3b"
  license "Apache-2.0"
  head "https://github.com/techwizrd/tapcue.git", branch: "main"

  livecheck do
    url "https://github.com/techwizrd/tapcue/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    man1.install "docs/man/tapcue.1"
    (pkgshare/"tldr-pages/pages/common").install "docs/tldr/tapcue.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tapcue --version")
    assert_match "tapcue", shell_output("#{bin}/tapcue --help")

    (testpath/"smoke.tap").write <<~EOS
      TAP version 14
      1..1
      ok 1 - smoke
    EOS

    output = shell_output("#{bin}/tapcue --no-notify --summary-format text --summary-file - --format tap < smoke.tap")
    assert_match "status=success", output

    assert_path_exists man1/"tapcue.1"
    assert_path_exists pkgshare/"tldr-pages/pages/common/tapcue.md"
  end
end
