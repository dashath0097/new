terraform {
  required_providers {
    spacelift = {
      source  = "Spacelift-io/spacelift"
      version = ">= 0.1.0"
    }
  }
}
provider "spacelift" {
  api_token = context.SPACELIFT_API_TOKEN
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
