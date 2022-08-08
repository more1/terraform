pipeline {
    agent any
    
    stages {
        
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/more1/terraform.git'
            }
        }
        
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        
        stage('Manual Approval') {
            steps {
                input message: 'Apply this Terraform?', ok: 'Yes'
            }
        }

        stage('Apply Terraform') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
