resource "random_string" "random" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}
resource "google_compute_instance_template" "instance_template" {
  name         = "${var.service_name}-instance-template-${random_string.random.result}"
  machine_type = var.machine_type
  region       = var.region

  // boot disk
  disk {
    // create a new boot disk from an image
    source_image = var.os_source_image
    auto_delete  = true
    boot         = true
    disk_size_gb = var.disk_size
    disk_type    = var.disk_type
  }

  // networking
  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    access_config {}
  }

  tags = var.network_tags

  metadata_startup_script = var.startup_script

  metadata = {
    startup-script-url = var.startup_script_url
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = false
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  depends_on = [random_string.random]
}

