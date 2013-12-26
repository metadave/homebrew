require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Erln8 < Formula
  homepage ''
  url 'https://github.com/metadave/erln8/archive/erln8-0.9.1.tar.gz'
  sha1 '68ee0a05b11bd0aa44eb78e330dafb110162ba68'

  depends_on 'glib'
  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'libffi'

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test erln8`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "erln8 --help"
  end
end
