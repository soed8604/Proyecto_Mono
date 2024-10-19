pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/soed8604/Proyecto_Mono.git']])
                }
            }
        }
        stage('Inicializar terraform'){
            steps{
                script{
                    dir('mono-eks-cluster'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatear el codigo de terraform'){
            steps{
                script{
                    dir('mono-eks-cluster'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validar la configuración de terraform'){
            steps{
                script{
                    dir('mono-eks-cluster'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previsualizar la Infraestructura usando Terraform'){
            steps{
                script{
                    dir('mono-eks-cluster'){
                        sh 'terraform plan'
                    }
                    input(message: "Estas seguro que quieres proceder", ok: "Proceder")
                }
            }
        }
        stage('Crear/Destruir un EKS Cluster'){
            steps{
                script{
                    dir('mono-eks-cluster') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        // stage('Deploying Nginx Application') {
        //     steps{
        //         script{
        //             dir('EKS/ConfigurationFiles') {
        //                 sh 'aws eks update-kubeconfig --name my-eks-cluster'
        //                 sh 'kubectl apply -f deployment.yaml'
        //                 sh 'kubectl apply -f service.yaml'
        //             }
        //         }
        //     }
        // }
        post {
            success {
                slackSend channel: '#canal-slack', message: 'Deploy del clúster EKS exitoso.'
            }
            failure {
                slackSend channel: '#canal-slack', message: 'El despliegue del clúster EKS ha fallado.'
        }
    }

    }
}
