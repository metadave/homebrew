require 'formula'
class Erln8 < Formula
  homepage ''
  url 'https://github.com/metadave/erln8/archive/erln8-0.9.2.tar.gz'
  sha1 'f982a25d3c7dd73d78da130e04578e3fc43d9de0'
  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'libffi'

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
    bash_completion.install 'bash_completion/erln8'
  end

  test do
    system "#{bin}/erln8 --help"
  end
end
