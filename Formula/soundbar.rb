class Soundbar < Formula
  desc "Menu bar app that pins one window, dims the rest, and times the session"
  homepage "https://github.com/quannh287/soundbar"
  url "https://github.com/quannh287/soundbar/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "f8c230fa93c9a3af1055ee218186721abc2c8b3b657a5f1acaec8f5aa8dba0d9"
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
      the window list to show window titles instead of app names.
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
