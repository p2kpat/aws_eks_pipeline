pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'  // Set your AWS region
    }
    stages {
        stage('Checkout') {
            steps {
                // Clone the Git repository containing the Terraform code
                git branch: 'main', url: 'https://github.com/p2kpat/aws_eks_pipeline.git'
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'devopsAdmin']]) {
                        sh '''
                            # Export AWS credentials as environment variables
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            export AWS_DEFAULT_REGION=${AWS_REGION}

                            # Initialize Terraform
                            terraform init
                        '''
                    }
                }
            }
        }
        stage('Terraform Validate') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'devopsAdmin']]) {
                        sh '''
                            # Export AWS credentials as environment variables
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            export AWS_DEFAULT_REGION=${AWS_REGION}

                            # Validate Terraform configuration
                            terraform validate
                        '''
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'devopsAdmin']]) {
                        sh '''
                            # Export AWS credentials as environment variables
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            export AWS_DEFAULT_REGION=${AWS_REGION}

                            # Run Terraform Plan
                            terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'devopsAdmin']]) {
                        sh '''
                            # Export AWS credentials as environment variables
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            export AWS_DEFAULT_REGION=${AWS_REGION}

                            # Apply Terraform Plan
                            terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up workspace or other tasks after build
            cleanWs()
        }
    }
}
