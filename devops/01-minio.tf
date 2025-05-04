// --------------------------------------------------------
// Kestra
// --------------------------------------------------------

resource "minio_iam_user" "kestra_store" {
  name          = "kestra-store"
  force_destroy = true
  update_secret = true
}

resource "minio_s3_bucket" "kestra_store" {
  bucket        = "kestra-store"
  force_destroy = true
  acl           = "private"
}

resource "minio_iam_service_account" "kestra_store" {
  target_user = minio_iam_user.kestra_store.name
}

resource "minio_iam_policy" "kestra_store" {
  name   = "kestra-store"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement": [
    {
      "Sid":"KestraStore",
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Principal":"*",
      "Resource": ["${minio_s3_bucket.kestra_store.arn}", "${minio_s3_bucket.kestra_store.arn}/*"]
    }
  ]
}
EOF
}

resource "minio_iam_user_policy_attachment" "kestra_store" {
  user_name   = minio_iam_user.kestra_store.id
  policy_name = minio_iam_policy.kestra_store.name
}

resource "null_resource" "minio" {
  depends_on = [
    // kestra-store
    minio_iam_user.kestra_store,
    minio_iam_service_account.kestra_store,
    minio_iam_user_policy_attachment.kestra_store,
    minio_iam_policy.kestra_store,
    minio_s3_bucket.kestra_store,
  ]
}
