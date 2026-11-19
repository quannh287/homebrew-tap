class Soundbar < Formula
  desc "Menu bar app that pins one window, dims the rest, and times the session"
  homepage "https://github.com/quannh287/soundbar"
  url "https://github.com/quannh287/soundbar/archive/refs/tags/v0.10.3.tar.gz"
  sha256 "b0bb51d6f1f5f204c8d9c673ad262cdee7d454c5b1ae75faa819ac817827380c"
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
