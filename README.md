# Google Compute Engine Instance Template Terraform Module

This Terraform module creates a Google Compute Engine instance template. It uses two separate startup scripts, one that is attached to the instance (and that we recommend using to install and update software) and other that is stored inside a GCS bucket.
This is made so that you can update the second script without having to recreate the instance template.

A sample of a script that we can use to update and install software is on `scripts/update_install.tpl`

## Usage

You can use this module by referencing it in your Terraform code:

```terraform
module "instance_template" {
  source  = "git@github.com:Retize-io/terraform_gce_instance_template.git?ref=v1.0.0"

  service_name           = "my-service"
  machine_type           = "n1-standard-1"
  region                 = "us-central1"
  os_source_image        = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size              = 10
  disk_type              = "pd-standard"
  network                = "network"
  network_tags           = ["web-server"]
  startup_script = templatefile("./scripts/update_install.tpl", {
    region ="us-central1"
  })
  startup_script_url     = "gs://my-bucket/startup-script.sh"
  service_account_email  = "my-service-account@my-project.iam.gserviceaccount.com"
  project_id             = "my-project-id"
}
```

Make sure to replace the values with your own service name, machine type, region, OS source image, disk size, disk type, network, network tags, startup script, startup script URL, service account email, and project ID.

## Inputs

| Name                  | Description                                                             | Type           | Default                             | Required |
| --------------------- | ----------------------------------------------------------------------- | -------------- | ----------------------------------- | -------- |
| service_name          | The name of the service to use in the instance template name.           | `string`       | n/a                                 | yes      |
| machine_type          | The machine type to use for the instance template.                      | `string`       | `"n1-standard-1"`                   | no       |
| region                | The region in which to create the instance template.                    | `string`       | `"us-central1"`                     | no       |
| os_source_image       | The name of the OS source image to use for the boot disk.               | `string`       | `"ubuntu-os-cloud/ubuntu-2204-lts"` | no       |
| disk_size             | The size of the boot disk in GB.                                        | `number`       | `10`                                | no       |
| disk_type             | The type of the boot disk.                                              | `string`       | `"pd-standard"`                     | no       |
| network               | The name of the network to use for the instance template.               | `string`       | `"retigazer-network"`               | no       |
| network_tags          | The list of tags to apply to the instance template.                     | `list(string)` | `[]`                                | no       |
| startup_script        | The startup script to apply to the instance template.                   | `string`       | `""`                                | no       |
| startup_script_url    | The URL of the startup script to apply to the instance template.        | `string`       | `""`                                | no       |
| service_account_email | The email address of the service account to use.                        | `string`       | n/a                                 | yes      |
| project_id            | The ID of the Google Cloud project where the resources will be created. | `string`       | n/a                                 | yes      |

## Outputs

| Name | Description                        |
| ---- | ---------------------------------- |
| id   | The ID of the instance template.   |
| name | The name of the instance template. |

## Contributing

Contributions are welcome! Please read the [contributing guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

This module is licensed under the Mozilla Public License 2.0. See [LICENSE](LICENSE) for full details.