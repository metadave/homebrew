require 'formula'
class Erln8 < Formula
  homepage ''
  url 'https://github.com/metadave/erln8/archive/erln8-0.9.7.tar.gz'
  sha1 'c6cfeb0adb5489b6a95374ef116f843a2d341cee'

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
