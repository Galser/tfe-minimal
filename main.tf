terraform {
  backend "remote" {
    hostname     = "tfe-pm-3.guselietov.com"
    organization = "acme"

    workspaces {
      name = "playground"
    }
  }
}

resource "random_pet" "pet" {
}

resource "null_resource" "non-timed-hello" {
  triggers = {
    pet_name = random_pet.pet.id
  }

  provisioner "local-exec" {
    command = "echo ${random_pet.pet.id}"
  }
}

resource "null_resource" "timed-hello" {
  triggers = {
    timey = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo Pet ${random_pet.pet.id} at ${timestamp()}"
  }
}
