locals {
  created_by    = var.owner
  environment   = var.environment
  sre_email     = var.sre_email

  common_tags = {
      Owner       = local.created_by
      Owner_email = local.sre_email
      Environment = local.environment
  }
}