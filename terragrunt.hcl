terraform {
  before_hook "before_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Running Terraform"]
  }

  after_hook "after_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Finished running Terraform"]
    run_on_error = true
  }

  error_hook "import_resource" {
    commands  = ["plan"]
    execute   = ["echo", "Import error hook executed"]
    on_errors = [
      "Invalid import id argument*",
    ]
  }
}
