provider "spacelift" {
  # Ensure Spacelift provider is configured correctly
}

resource "spacelift_worker_pool" "private_pool" {
  name        = "private-worker-pool"
  description = "Private worker pool for running Terraform plans"
}
