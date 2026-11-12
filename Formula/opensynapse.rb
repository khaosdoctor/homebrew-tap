class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.3.0"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.3.0/opensynapse-0.3.0-x86_64.tar.gz"
    sha256 "f8ce43818fb1a9aac3738870c1d831b48e3fe9f0f669043520dfb478e0a31a32"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.3.0/opensynapse-0.3.0-aarch64.tar.gz"
    sha256 "38a397fbc9b6f6329bc932c7d6776f0e8a33dc2f812928c0193f0841a55199e0"
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
