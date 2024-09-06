pipeline 
{
    agent any
	
#    environment 
#	{
#        AWS_DEFAULT_REGION = 'us-east-1'  // Set your AWS region
#    }

    stages 
	{
        stage('Checkout') 
		{
            steps 
			{
                dir('/home/priyankkpgmail') 
				{
                    git 'https://github.com/p2kpat/aws_eks_pipeline.git' // Clone the repository, note this is the HTTP url NOT ssh url.
                }
            }
        }
        stage('Verify Terraform Installation') 
		{
            steps
			{
                sh 'terraform --version'  // Check Terraform installation
            }
        }
		
#        stage('Set AWS Credentials') 
#		{
#            steps 
#			{
#                // Inject AWS credentials from Jenkins Credentials Manager using the below funciton
#                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'do_admin1']])
#				{
#                    sh '''
#                        # Export AWS credentials as environment variables
#                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
#                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
#                        #export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
#
#                        # Optionally check AWS CLI access
#                        aws sts get-caller-identity
#                    '''
#                }
#            }
#        }
		
        stage('Terraform Init')
		{
            steps 
			{
                dir('/home/priyankkpgmail/aws_eks_pipeline') 
				{
                    sh 'terraform init' // Initialize Terraform
                }
            }
        }
		
        stage('Terraform Validate') 
		{
            steps 
			{
                dir('/home/priyankkpgmail/aws_eks_pipeline') 
				{
                    sh 'terraform validate' // Validate Terraform configuration
                }
            }
        }
		
        stage('Terraform Plan') 
		{
            steps 
			
                dir('/home/priyankkpgmail/aws_eks_pipeline') 
				{
                    sh 'terraform plan' // Create a Terraform plan
                }
            }
        }
		
        stage('Terraform Apply') 
		{
            steps 
			{
                dir('/home/priyankkpgmail/aws_eks_pipeline') 
				{
                    sh 'terraform apply -auto-approve' // Apply the Terraform plan
                }
            }
        }
    }
#    post {
#        always {
#            // Cleanup actions or notifications
#        }
#    }
}
