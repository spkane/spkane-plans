pkg_name=minecraft_server_spigot
pkg_origin=spkane
pkg_version=1.12.2
pkg_maintainer="Sean P. Kane <spkane00@gmail.com>"
pkg_license=('Minecraft End User License Agreement')
pkg_source=https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
pkg_filename=BuildTools.jar
pkg_build_deps=(core/jre8 core/git core/bash)
pkg_deps=(core/jre8 core/curl core/bash)
pkg_upstream_url=https://www.spigotmc.org/
pkg_interpreters=(bin/bash)
pkg_svc_user=root
pkg_svc_group=root
#pkg_expose=(25565)

do_unpack() {
  return 0
}

do_verify() {
  return 0
}

do_build() {
  mkdir -p $(pkg_path_for core/git)/etc 
  $(pkg_path_for core/git)/bin/git config --global core.autocrlf false
  $(pkg_path_for core/jre8)/bin/java -Xmx2048M -jar ../${pkg_filename} --rev ${pkg_version}
  return $?
}

do_prepare()
{
    export JAVA_HOME=$(hab pkg path core/jre8)
}

do_check() {
   return 0
}

do_strip() {
  return 0
}

do_install() {
  pwd
  ls -lFaR
  cp ./spigot-${pkg_version}.jar "$pkg_prefix"/spigot.jar
  cp ${PLAN_CONTEXT}/ops.sh "$pkg_prefix"/ops.sh
  fix_interpreter "$pkg_prefix"/ops.sh core/bash bin/bash
  chmod u+rx "$pkg_prefix"/ops.sh
  return $?
}

do_clean() {
  return 0
}


