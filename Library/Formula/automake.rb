require 'formula'

class Automake < Formula
  homepage 'http://www.gnu.org/software/automake/'
  url 'http://ftpmirror.gnu.org/automake/automake-1.12.4.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/automake/automake-1.12.4.tar.gz'
  sha1 'c474eb8c058d93ead9b2433fbcfb0c349517e171'

  # Always needs a newer autoconf, even on Snow Leopard.
  depends_on 'autoconf'

  if MacOS::Xcode.provides_autotools? or File.file? "/usr/bin/automake"
    keg_only "Xcode (up to and including 4.2) provides (a rather old) Automake."
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"

    # Our aclocal must go first. See:
    # https://github.com/mxcl/homebrew/issues/10618
    (share/"aclocal/dirlist").write <<-EOS.undent
      #{HOMEBREW_PREFIX}/share/aclocal
      /usr/share/aclocal
    EOS
  end

  def test
    system "#{bin}/automake", "--version"
  end
end