[
  {
    "cpu": ${fargate_cpu},
    "image": "${app_image}",
    "memory": ${fargate_memory},
    "name": "app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]