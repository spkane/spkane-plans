pkg_name=geoip
pkg_origin=spkane
pkg_version=1.6.9
pkg_maintainer="Sean P. Kane <spkane00@gmail.com>"
pkg_license=('maxmind')

pkg_source="https://github.com/maxmind/geoip-api-c/releases/download/v1.6.9/GeoIP-1.6.9.tar.gz"
pkg_shasum=4b446491843de67c1af9b887da17a3e5939e0aeed4826923a5f4bf09d845096f
pkg_filename="${pkg_name}_${pkg_version}.tar.gz"
pkg_dirname=GeoIP-${pkg_version}

pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/diffutils core/file core/glibc)


do_build() {
  ln -f -s $(pkg_path_for core/file)/bin/file /usr/bin
  do_default_build
  return $?
}