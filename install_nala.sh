# not working

install_nala() {
  local nala_deb_path="nala_0.11.0_all.deb"
  curl -O "https://deb.volian.org/volian/pool/main/n/nalha/$nala_deb_path"
  sudo apt install "./${nala_deb_path}"
  sudo apt install -f
}

install_nala

