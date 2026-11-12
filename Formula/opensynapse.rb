class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.2.8"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.8/opensynapse-0.2.8-x86_64.tar.gz"
    sha256 "d462ee4d2261c898ccb3ceca30d089db38ff580d0b279ff496248dc1e845c9ab"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.8/opensynapse-0.2.8-aarch64.tar.gz"
    sha256 "2f619ed94beb746bc806d7452b9f91f403a499f42808aa0ce33917f65adb4e16"
  end

  def install
    bin.install "opensynapse", "opensynapse-gui"
    pkgshare.install "udev/70-opensynapse.rules"
    (pkgshare/"devices").install Dir["devices/*.jsonc"]
    (share/"applications").install "assets/opensynapse.desktop"
    (share/"icons/hicolor/scalable/apps").install "assets/icon.svg" => "opensynapse.svg"
    doc.install "README.md", "PROTOCOL.md"
    bash_completion.install "completions/opensynapse.bash" => "opensynapse"
    zsh_completion.install "completions/_opensynapse"
    fish_completion.install "completions/opensynapse.fish"
  end

  def caveats
    <<~EOS
      opensynapse needs access to the mouse's raw HID device. Install the udev rule once:
        sudo install -m644 #{opt_pkgshare}/70-opensynapse.rules /etc/udev/rules.d/
        sudo udevadm control --reload && sudo udevadm trigger
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/opensynapse help")
  end
end
