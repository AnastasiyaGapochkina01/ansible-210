output "internal_backend_ips" {
  value = { for vm in yandex_compute_instance.backends : vm.name => vm.network_interface.0.ip_address }
}

output "internal_db_ip" {
  value = yandex_compute_instance.db.network_interface.0.ip_address
}

output "internal_proxy_ip" {
  value = yandex_compute_instance.proxy.network_interface.0.ip_address
}
