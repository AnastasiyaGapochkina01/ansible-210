resource "yandex_vpc_network" "backend" {
  name = "backend"
}

resource "yandex_vpc_subnet" "backend_subnet" {
  name = "backend-subnet"
  network_id = "${yandex_vpc_network.backend.id}"
  v4_cidr_blocks = [var.cidr_block]
}
