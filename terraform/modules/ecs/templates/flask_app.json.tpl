[
  {
    "name": "flask-app",
    "image": "${docker_image_url_flask}",
    "essential": true,
    "cpu": 10,
    "memory": 512,
    "links": [],
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],
    "command": ["gunicorn", "-w", "3", "-b", ":5000", "notejam.wsgi:application"],
    "environment": [
      {
        "name": "FLASK_APP",
        "value": "${flask_app}"
      },
      {
        "name": "DATABASE",
        "value": "rds"
      },
      {
        "name": "RDS_DB_NAME",
        "value": "${rds_db_name}"
      },
      {
        "name": "RDS_USERNAME",
        "value": "${rds_username}"
      },
      {
        "name": "RDS_PASSWORD",
        "value": "${rds_password}"
      },
      {
        "name": "RDS_HOSTNAME",
        "value": "${rds_hostname}"
      },
      {
        "name": "RDS_PORT",
        "value": "${rds_port}"
      }      
    ],    
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/notejam-flask",
        "awslogs-region": "${region}",   
        "awslogs-stream-prefix": "notejam-flask-log-stream"
      }
    }
  },
  {
    "name": "nginx",
    "image": "${docker_image_url_nginx}",
    "essential": true,
    "cpu": 10,
    "memory": 128,
    "links": ["flask-app"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],    
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/nginx",
        "awslogs-region": "${region}",   
        "awslogs-stream-prefix": "nginx-log-stream"
      }
    }
  }
]
