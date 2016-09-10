pkg_name=minecraft_server
pkg_origin=spkane
pkg_version=1.10.2
pkg_maintainer="Sean P. Kane <spkane00@gmail.com>"
pkg_license=('Minecraft End User License Agreement')
pkg_source=https://s3.amazonaws.com/Minecraft.Download/versions/${pkg_version}/${pkg_name}.${pkg_version}.jar
pkg_filename=${pkg_name}.${pkg_version}.jar
pkg_shasum=195f468227c5f9218f3919538b9b16ba34adced67fc7d7b652c508a5e8d07a21
pkg_deps=(core/glibc core/server-jre core/curl core/bash)
pkg_upstream_url=https://minecraft.net/
pkg_interpreters=(bin/bash)
#pkg_expose=(25565)

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_check() {
   return 0
}

do_strip() {
  return 0
}

do_install() {
  cp ../${pkg_filename} "$pkg_prefix"/minecraft_server.jar
  cp ${PLAN_CONTEXT}/ops.sh "$pkg_prefix"/ops.sh
  fix_interpreter "$pkg_prefix"/ops.sh core/bash bin/bash
  chmod u+rx "$pkg_prefix"/ops.sh
  return $?
}

do_clean() {
  return 0
}


