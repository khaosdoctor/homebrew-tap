class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.2.4"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.4/opensynapse-0.2.4-x86_64.tar.gz"
    sha256 "73a07ec48aec6a3ea00b92832d08265cf5055b1a03f69b44e97128d7f38684e9"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.4/opensynapse-0.2.4-aarch64.tar.gz"
    sha256 "f71d10011de31d35a76141602b1361ca150b1d8522b4deb5dc81fbb02b7cb92c"
  end

  def install
    bin.install "opensynapse", "opensynapse-gui"
    pkgshare.install "udev/70-opensynapse.rules"
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
