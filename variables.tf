variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket."
}

variable "region" {
  type = string
  description = "The AWS region where the bucket will be created."
}

variable "tags" {
  type = map(string)
  description = "Optional tags for the bucket."
  default = {}
}

variable "acl" {
  type = string
  description = "The access control list for the bucket. Valid options: private, public-read, etc."
  default = "private"
}

variable "versioning" {
  type = bool
  description = "Whether to enable versioning for the bucket."
  default = false
}

variable "logging" {
  type = object({
    target_bucket = string
    target_prefix = string
  })
  description = "Optional configuration for logging access to the bucket."
  default = {}
}

variable "lifecycle_rules" {
  type = list(object({
    id = string
    prefix = string
    tags = map(string)
    enabled = bool
    transitions = list(object({
      days = number
      storage_class = string
    }))
    # ... other lifecycle rule options
  }))
  description = "Optional lifecycle rules for the bucket."
  default = []
}
