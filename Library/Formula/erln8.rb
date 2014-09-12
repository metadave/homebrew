require 'formula'
class Erln8 < Formula
  homepage ''
  url 'https://github.com/metadave/erln8/archive/erln8-0.9.9.tar.gz'
  sha1 'fa7615a1b7850a591389c1d5290737f5df898e3e'

  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'libffi'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'unixodbc'

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
    bash_completion.install 'bash_completion/erln8'
  end

  test do
    system "#{bin}/erln8 --help"
  end
end
