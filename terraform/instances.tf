resource "yandex_compute_instance" "backends" {
  for_each = toset(var.vm_names)
  name = "${var.vm_prefix}-${each.key}"
  zone = var.zone
  hostname = "${each.key}"

  resources {
    cores = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.disk_size
      type = "network-hdd"
      name = "${var.vm_prefix}-${each.key}"
    }
  }

  network_interface {
    subnet_id = "e2lud43im0lgoavd0092"
    nat = true
  }

  connection {
    host = "${self.network_interface.0.ip_address}"
    type = "ssh"
    user = "anestesia"
    private_key = "${file("/home/anestesia/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    script = "scripts/wait-host.sh"
  }

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook -i '${self.network_interface.0.ip_address},' backend.yaml"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}

resource "yandex_compute_instance" "proxy" {
  name = "${var.vm_prefix}-proxy-1"
  zone = var.zone
  hostname = "${var.vm_prefix}-proxy-1"

  resources {
    cores = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.disk_size
      type = "network-hdd"
      name = "${var.vm_prefix}-proxy-1"
    }
  }

  network_interface {
    subnet_id = "e2lud43im0lgoavd0092"
    nat = true
  }

  connection {
    host = "${self.network_interface.0.ip_address}"
    type = "ssh"
    user = "anestesia"
    private_key = "${file("/home/anestesia/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    script = "scripts/wait-host.sh"
  }

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook -i '${self.network_interface.0.ip_address},' proxy.yaml"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}

resource "yandex_compute_instance" "db" {
  name = "${var.vm_prefix}-db-1"
  zone = var.zone
  hostname = "${var.vm_prefix}-db-1"

  resources {
    cores = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.disk_size
      type = "network-hdd"
      name = "${var.vm_prefix}-db-1"
    }
  }

  network_interface {
    subnet_id = "e2lud43im0lgoavd0092"
    nat = true
  }

  connection {
    host = "${self.network_interface.0.ip_address}"
    type = "ssh"
    user = "anestesia"
    private_key = "${file("/home/anestesia/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    script = "scripts/wait-host.sh"
  }

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook -i '${self.network_interface.0.ip_address},' postgres.yaml"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}
