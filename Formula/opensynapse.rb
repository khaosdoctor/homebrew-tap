# Template for khaosdoctor/homebrew-tap. .github/workflows/release.yml fills in
# the version and checksums on every release and pushes it to the tap.
class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.2.0"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.0/opensynapse-0.2.0-x86_64.tar.gz"
    sha256 "680de3a0fb79f9d78437f14867f63aa5dc6330cc98c749b0b575739489998114"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.0/opensynapse-0.2.0-aarch64.tar.gz"
    sha256 "cdf7230bef738c8d2a5fc5bebfa52a4f7b511af1b424aa17291dd6e57a0d4070"
  end

  def install
    bin.install "opensynapse", "opensynapse-gui"
    pkgshare.install "udev/70-opensynapse.rules"
    (share/"applications").install "assets/opensynapse.desktop"
    (share/"icons/hicolor/scalable/apps").install "assets/icon.svg" => "opensynapse.svg"
    doc.install "README.md", "PROTOCOL.md"
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
