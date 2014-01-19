require "formula"

class Waxeye < Formula
  homepage "http://waxeye.org/"
  url "https://github.com/orlandohill/waxeye/archive/0.8.0.tar.gz"
  sha1 "f16febc792b0e4711b4e22e280b7cf5efb4c9833"

  # I included C and Java as build options here because
  # a) C doesn't have a package system and it's really convenient to include
  # and
  # b) I feel bad for anyone that has to use Java build tools
  option 'with-c', "Build Waxeye C runtime"
  option 'with-java', "Build Waxeye Java runtime"

  depends_on "plt-racket" => :build

  ## generate a wrapper that doesn't need to be run from
  ## a specific directory
  def waxeye_wrapper; <<-EOS.undent
    #!/bin/sh
    mzscheme -t #{prefix}/src/waxeye/waxeye.scm -- $*
    EOS
  end

  def install
    # waxeye contains source for C/Racket/js/Java/Ruby/Python
    # copy it all so the library is complete
    system "cp -r LICENSE README build docs grammars src test #{prefix}"
    # allow racket to see waxeye
    collects_path =
      "#{Formula.factory('plt-racket').opt_prefix}/lib/racket/collects/waxeye"
    system "cp -r #{prefix}/src/scheme/waxeye/ #{collects_path}"
    # make a bin directory
    system "mkdir #{prefix}/bin"
    # generate a waxeye wrapper
    (bin/'waxeye').write(waxeye_wrapper)

    if build.with? 'c'
      puts "Building Waxeye C runtime"
      system "cd src/c && make lib"
      ln_s "#{prefix}/src/c/include", include
      lib.install "src/c/libwaxeye.a"
    end

    if build.with? 'java'
      system "cd src/java && find . -name *.java | xargs javac && jar cvf ./waxeye.jar *"
      lib.install "src/java/waxeye.jar"
    end

  end

  def caveats
    <<-EOS.undent
      for more information on how to use Waxeye from your language of choice,
      see: http://waxeye.org/manual.html

      To use Waxeye from C:
          install Waxeye via homebrew with --with-c
          To include and link against Waxeye:
          gcc -I #{prefix}/include -L #{prefix}/lib/libwaxeye.a foo.c -lwaxeye -o foo

      To use Waxeye from Java:
        install Waxeye via homebrew with --with-java
        Include #{prefix}/lib/waxeye.jar in your CLASSPATH

      To use Waxeye from Javascript:
        mkdir -p ~/.node_libraries
        #{prefix}/src/javascript/waxeye.js ~/.node_libraries

      To use Waxeye from Python:
        pip install waxeye
           or
        cd #{prefix}/src/python
        python setup.py build
        python setup.py install

      To use Waxeye from Ruby:
        install the waxeye gem from RubyForge:
          http://rubyforge.org/projects/waxeye/

      To use Waxeye from Scheme:
        Racket collects are already installed for you!

    EOS
  end

  test do
    system "#{bin}/waxeye", "-h"
  end
end
