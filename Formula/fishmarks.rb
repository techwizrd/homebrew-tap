class Fishmarks < Formula
  desc "Directory bookmarks for Fish shell"
  homepage "https://github.com/techwizrd/fishmarks"
  url "https://github.com/techwizrd/fishmarks/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "33c9655c932986dab371156bbe0b3f8d812da1fe232ea84b425f781fc0463f9c"
  license "Apache-2.0"
  head "https://github.com/techwizrd/fishmarks.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "fish"

  def install
    fish_function.install Dir["functions/*.fish"]
    fish_completion.install Dir["completions/*.fish"]
    (share/"fish/vendor_conf.d").install "conf.d/fishmarks.fish"
  end

  def caveats
    <<~EOS
      fishmarks stores bookmarks in ~/.sdirs.

      `brew uninstall techwizrd/tap/fishmarks` removes only Homebrew-managed plugin files.
      Your bookmarks are kept by default.

      Optional full cleanup:
        rm -f ~/.sdirs
        rm -f ~/.config/fish/conf.d/fishmarks.fish

      If you previously used a manual clone install:
        rm -rf ~/.fishmarks
    EOS
  end

  test do
    fish = Formula["fish"].opt_bin/"fish"

    check = "type -q save_bookmark; and type -q go_to_bookmark; and type -q fishmarks_version; and echo ok"
    assert_equal "ok", shell_output("#{fish} -c '#{check}'").strip

    system fish, "-c", <<~FISH
      set -gx SDIRS "#{testpath}/.sdirs"
      mkdir -p "#{testpath}/proj"
      cd "#{testpath}/proj"
      save_bookmark proj
      cd /
      go_to_bookmark proj
      test "$PWD" = "#{testpath}/proj"
    FISH
  end
end
