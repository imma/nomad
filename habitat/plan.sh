pkg_origin=imma
pkg_name=nomad
pkg_version=0.7.1
pkg_description="nomad"
pkg_maintainer='Amanibhavam <iam@defn.sh>'
pkg_license=("MPL-2.0")
pkg_upstream_url=https://www.nomadproject.io/
pkg_source=https://releases.hashicorp.com/nomad/${pkg_version}/nomad_${pkg_version}_linux_amd64.zip
pkg_shasum=72b32799c2128ed9d2bb6cbf00c7600644a8d06c521a320e42d5493a5d8a789a
pkg_filename=${pkg_name}-${pkg_version}_linux_amd64.zip
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_exports=(
  [port]=listener.port
)
pkg_exposes=(port)

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D nomad "${pkg_prefix}"/bin/nomad
}
