class Opensynapse < Formula
  desc "Remap buttons, set DPI and lighting on Razer mice from Linux"
  homepage "https://github.com/khaosdoctor/opensynapse"
  version "0.2.2"
  license "GPL-2.0-or-later"

  depends_on :linux

  on_intel do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.2/opensynapse-0.2.2-x86_64.tar.gz"
    sha256 "9509b316e5b0780fcae7b93b5decf299ec22e637c8dc16a79826d03f8e6c14bf"
  end

  on_arm do
    url "https://github.com/khaosdoctor/opensynapse/releases/download/v0.2.2/opensynapse-0.2.2-aarch64.tar.gz"
    sha256 "dbd1f8a580e7a66b1159920a3a82977aa132a129639c50d801cc5d9ebf5b1de5"
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
