output "lb_url" {
    value       = "http://${module.alb.lb_dns_name}"
    description = "URL pública do Load Balancer"
}