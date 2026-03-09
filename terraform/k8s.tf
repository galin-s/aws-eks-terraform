# --- Kubernetes provider ---
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.terraform.token
}

# --- Auth for Terraform user ---
data "aws_eks_cluster_auth" "terraform" {
  name = module.eks.cluster_name
}

# --- Deployment ---
resource "kubernetes_deployment_v1" "nginx" {
  metadata {
    name      = "nginx-demo"
    labels = {
      app = "nginx-demo"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx-demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-demo"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:1.24"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# --- Service ---
resource "kubernetes_service_v1" "nginx" {
  metadata {
    name      = "nginx-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.nginx.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
