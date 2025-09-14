resource "aws_secretsmanager_secret" "mongo" {
  name = "${var.project}-mongo"
}

resource "aws_secretsmanager_secret_version" "mongo_version" {
  secret_id     = aws_secretsmanager_secret.mongo.id
  secret_string = jsonencode({ MONGO_URI = var.mongo_uri })
}
