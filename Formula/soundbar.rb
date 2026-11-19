class Soundbar < Formula
  desc "Menu bar mixer for Apple's built-in Background Sounds"
  homepage "https://github.com/quannh287/soundbar"
  url "https://github.com/quannh287/soundbar/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "0111ecd47a2e44947f00e1e2f0ff3d863b14ecb026721fe81c8cf1869137a391"
  license "MIT"
  head "https://github.com/quannh287/soundbar.git", branch: "main"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "SoundBar.app"
  end

  def caveats
    <<~CAVEAT
      SoundBar is a menu bar app, not a command. Open it with:
        open #{opt_prefix}/SoundBar.app

      Then turn on "Open at Login" from the ⋯ menu so it comes back after a reboot.
    CAVEAT
  end

  test do
    # The app's own --list check needs network and a writable cache, which the test
    # sandbox denies; assert the bundle shape instead.
    assert_path_exists prefix/"SoundBar.app/Contents/MacOS/SoundBar"
    assert_match "LSUIElement", (prefix/"SoundBar.app/Contents/Info.plist").read
    system "codesign", "--verify", prefix/"SoundBar.app"
  end
end
