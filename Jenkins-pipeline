pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION = 'us-west-2'
    }

    stages {
        stage('Terraform Apply') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
        
        stage('Ansible Deploy') {
            steps {
                ansiblePlaybook(
                    playbook: 'minecraft-deploy.yml',
                    inventory: 'inventory.ini',
                    sshUser: 'ubuntu',
                    become: true,
                    extras: '-e minecraft_image=itzg/minecraft-server'
                )
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                sh 'kubectl apply -f minecraft.yaml'
            }
        }
    }
}
