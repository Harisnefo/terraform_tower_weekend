Note: Jenkis Terraform plugin version
Terraform 30816 linux (386)

Pipeline Confuguration to deploy VPC abd EC2

pipeline {
    agent any

    tools{
        terraform 'terraform'
    }

    stages {

        stage('Git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Harisnefo/terraform_tower_weekend.git']])
            }
        }


        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform plan') {
            steps {
                sh 'terraform plan -var-file=environment/dev.tfvars'
            }
        }

        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve -var-file environment/dev.tfvars'
            }
        }

        stage('Terraform destroy') {
            steps {
                sh 'terraform destroy --auto-approve -var-file environment/dev.tfvars'
            }
        }


    }
}



                 OR



pipeline {
    agent any

    tools{
        terraform 'terraform'
    }

    stages {

        stage('Git checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Harisnefo/terraform_tower_weekend.git']])
            }
        }


        stage('Terraform Deploy') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -var-file=environment/dev.tfvars'
                sh 'terraform apply --auto-approve -var-file environment/dev.tfvars'
                sh 'sleep 60'
                sh 'terraform destroy --auto-approve -var-file environment/dev.tfvars'
            }
        }

    }
}


