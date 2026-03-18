resource "helm_release" "argocd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace        = "argocd"
  create_namespace = true
}

resource "kubernetes_manifest" "nginx_app" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(file("${path.module}/../gitops/nginx-app.yaml"))
}