pipeline 
{
    agent any

//   environment 
//	{
//	PATH = "/usr/bin:${env.PATH}"
//        AWS_DEFAULT_REGION = 'us-east-1'  // Set your AWS region
//    }

    stages 
    {
        stage('Check Jenkins PATH')
	{
            steps 
            {
                sh 'echo $PATH'
            }
        }
        
        stage('Checkout')
	{
            steps 
	    {
		cleanWs() // Clears the workspace
                git url: 'https://github.com/p2kpat/aws_eks_pipeline.git', branch: 'main'
            }
        }

        stage('Verify Terraform Installation') 
	{
            steps
	    {
                sh 'terraform --version'  // Check Terraform installation
            }
        }

        stage('Set AWS Credentials') 
	{
            steps 
	    {
                // Inject AWS credentials from Jenkins Credentials Manager using the below funciton
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'do_admin1']])
	        {
                    sh '''
                        # Export AWS credentials as environment variables
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

       //                 # Optionally check AWS CLI access
       //                 aws sts get-caller-identity
                    '''
                }
            }
        }
        
        stage('Terraform Init')
	{
            steps 
            {
               sh 'terraform init' // Initialize Terraform
            }
        }
		
        stage('Terraform Validate') 
	{
            steps 
            {
               sh 'terraform validate' // Validate Terraform configuration
            }
        }
		
        stage('Terraform Plan') 
	{
            steps 
	    {
                    sh 'terraform plan' // Create a Terraform plan
            }
        }
		
        stage('Terraform Apply') 
	{
            steps 
	    {
                    sh 'terraform apply -auto-approve' // Apply the Terraform plan
            }
        }
    }
/*
begin comment
    post {
        always {
            // Cleanup actions or notifications
        }
    }
end commnent
*/
}
