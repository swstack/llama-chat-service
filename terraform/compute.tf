resource "google_compute_instance" "llama_gpu_vm" {
  name         = "llama-gpu-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["llama", "personal"]

  boot_disk {
    initialize_params {
      image = "projects/deeplearning-platform-release/global/images/common-cu118-v20240306-debian-11"
    }
  }

  guest_accelerator {
    type  = "nvidia-tesla-t4"
    count = 1
  }

  scheduling {
    provisioning_model = "SPOT"
    preemptible = true
    automatic_restart = false
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    email  = google_service_account.llama_compute_sa.email
    scopes = ["cloud-platform"]
  }
}
