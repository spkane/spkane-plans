pkg_name=heka
pkg_origin=spkane
pkg_version=e879938
pkg_maintainer="Sean P. Kane <spkane00@gmail.com>"
pkg_license=('MPL')

pkg_source="https://codeload.github.com/mozilla-services/heka/tar.gz/e879938"
pkg_shasum=0aac2392b869db9585d2ffd6aea1123aeebc371e88bec3eddc94f09a991fae79
pkg_filename="${pkg_name}_${pkg_version}.tar.gz"

pkg_deps=(core/glibc core/ncurses core/readline)
pkg_build_deps=(spkane/geoip core/cacerts core/readline core/pkg-config core/ncurses core/cmake core/make core/gcc core/git core/patch core/glibc core/go)

## Building Golang Apps in Habitat:
##  - Include 'core/go' as a build_dep
##  - Use 'go build -o xxx' in the source directory,
##    this avoids needing to have a properly configured GOPATH

do_download(){
  return 0
}

do_verify() {
  return 0
}

do_clean() {
  rm -f /usr/include/*.h
  rm -f /usr/lib/lib*
  rm -f /usr/lib/readline
  do_default_clean
  return $?
}

do_unpack() {
  cd $HAB_CACHE_SRC_PATH
  git config --global http.sslCAInfo $(pkg_path_for core/cacerts)/ssl/certs/cacert.pem
  git config --global advice.detachedHead false
  git clone https://github.com/mozilla-services/heka.git $pkg_dirname
  return $?
}

do_build() {
  ln -f -s $(pkg_path_for spkane/geoip)/include/*.h /usr/include/
  ln -f -s $(pkg_path_for spkane/geoip)/lib/lib* /usr/lib/
  ln -f -s $(pkg_path_for core/readline)/include/readline /usr/include/readline
  ln -f -s $(pkg_path_for core/readline)/lib/lib* /usr/lib/
  sed -i -e "s|-rpath,$ORIGIN/../lib|-rpath,$ORIGIN/../lib,-rpath,$(pkg_path_for core/ncurses)/lib|g" CMakeLists.txt
  source ./build.sh -Wno-dev
  return $?
}

do_check() {
   make test
   return $?
}

do_strip() {
  return 0
}

do_install() {
  cd build
  make install
  return $?
}
