module "iam_basic" {
  source = "../../modules/iam_basic"

  project_name = var.project_name
  environment  = var.environment
}