YXBpOjAxSk1FUjZENkNaMlcyUTdWN1FEUlNLOUcwOmM1ZTdlYmY3YzEzNDQ2YzAzMjc4MDc1MjY3OGFjMjJlMTZmZDE5ZTQzODU0MjI5NWQ4N2U4MjBlMzEyZTRhOTA
terraform
provider "spacelift" {

  token ="YXBpOjAxSk1FUjZENkNaMlcyUTdWN1FEUlNLOUcwOmM1ZTdlYmY3YzEzNDQ2YzAzMjc4MDc1MjY3OGFjMjJlMTZmZDE5ZTQzODU0MjI5NWQ4N2U4MjBlMzEyZTRhOTA"
}

resource "spacelift_worker_pool" "example" {
  name        = "example-private-worker-pool"
  description = "Example private worker pool"
  region      = "us-east-1" // Optional, defaults to 'us-east-1'
  worker_type = "standard" // Optional, defaults to 'standard'
  private     = true // Create a private worker pool
}

resource "spacelift_worker" "example" {
  worker_pool_id = spacelift_worker_pool.example.id
  name            = "example-worker"
  instance_type   = "t3.micro" // Optional, defaults to 't3.micro'
  region          = "us-east-1" // Optional, defaults to 'us-east-1'
  initial_state   = "Ready" // Set the initial state to 'Ready'
}
