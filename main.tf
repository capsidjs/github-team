variable "github_token" {
  type = "string"
}

variable "admins" {
  type = "list"

  default = [
    "kt3k",
  ]
}

variable "members" {
  type = "list"

  default = [
    "hinosawa",
  ]
}

provider "github" {
  token        = "${var.github_token}"
  organization = "capsidjs"
}

resource "github_team" "core" {
  name        = "core"
  description = "Core maintainers"
  privacy     = "closed"
}

resource "github_membership" "admin" {
  count    = "${length(var.admins)}"
  username = "${element(var.admins, count.index)}"
  role     = "admin"
}

resource "github_membership" "member" {
  count    = "${length(var.members)}"
  username = "${element(var.members, count.index)}"
  role     = "member"
}

resource "github_team_membership" "maintainer" {
  count    = "${length(var.admins)}"
  team_id  = "${github_team.core.id}"
  username = "${element(var.admins, count.index)}"
  role     = "maintainer"
}

resource "github_team_membership" "member" {
  count    = "${length(var.members)}"
  team_id  = "${github_team.core.id}"
  username = "${element(var.members, count.index)}"
  role     = "member"
}
