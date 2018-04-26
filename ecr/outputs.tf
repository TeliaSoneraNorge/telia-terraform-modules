output "container_repo_arn" {
  description = "Full ARN of the repository."
  value       = "${aws_ecr_repository.this.arn}"
}

output "container_repo_repository_url" {
  description = "The URL of the repository."
  value       = "${aws_ecr_repository.this.repository_url}"
}
