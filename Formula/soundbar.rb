class Soundbar < Formula
  desc "Menu bar app that pins one window, dims the rest, and times the session"
  homepage "https://github.com/quannh287/soundbar"
  url "https://github.com/quannh287/soundbar/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "c7cbb7b2f7a5aa0035418b7391af20ddd69f6cd94942b49ae7d4257c2f2c74c0"
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

      Focus mode needs no permissions. Grant Screen Recording only if you want
      the window list to show window titles instead of app names, and
      Accessibility only if you tick "Full screen while focusing" — that grant
      has to be switched on again after every upgrade.
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
