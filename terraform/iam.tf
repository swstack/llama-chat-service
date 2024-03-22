resource "google_service_account" "llama_compute_sa" {
  account_id   = "llama-compute-sa"
  display_name = "Service account used for llama compute"
}

resource "google_project_iam_member" "llama_compute_sa_role" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.llama_compute_sa.email}"
}
