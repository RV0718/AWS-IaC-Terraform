[
    {
        "name": "${container_name}",
        "image": "${container_image}:${image_tag}",
        "cpu": "${container_cpu}",
        "memory": "${container_memory}",
        "portMappings": [
            {
                "containerPort": "${container_port}",
                "hostPort": "${container_port}",
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "entryPoint": [],
        "command": [],
        "environment": [],
        "mountPoints": [],
        "volumesFrom": []
    }
]