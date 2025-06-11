resource "aws_iam_policy" "ecr_access" {
  name        = "ECRReadOnlyPolicy"
  description = "Allow EKS nodes to read from ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_ecr" {
  policy_arn = aws_iam_policy.ecr_access.arn
  role       = module.eks.eks_managed_node_groups["default"].iam_role_name
}
