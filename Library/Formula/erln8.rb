require 'formula'
class Erln8 < Formula
  homepage ''
  url 'https://github.com/metadave/erln8/archive/erln8-0.9.6.tar.gz'
  sha1 '5c72a1ae8a2af016021217fe77d53795dcca4381'

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
