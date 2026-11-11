class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.2.5"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.5/opensynapse-0.2.5-x86_64.tar.gz"
    sha256 "99c03967227db1cd67992493cb35c31cd1c10149cf433f4bcbb8a35a5f4aebac"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.5/opensynapse-0.2.5-aarch64.tar.gz"
    sha256 "a80ac22f303ebabb9a61bea244b9bc492c81168e1575293eb709845e3091f283"
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
