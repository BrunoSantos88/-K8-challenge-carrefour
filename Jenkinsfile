pipeline {
agent any

tools { 
///Depentencias 
maven 'Maven 3.6.3' 
terraform 'Terraform 1.3.7' 
}
environment {
//Chaves
AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
DOCKERHUB_CREDENTIALS = credentials('dockerlogin')
}

//Stages.
stages {   

stage('GIT CLONE') {
steps {
                // Get code from a GitHub repository
git url: 'https://github.com/BrunoSantos88/-K8-challenge-carrefour.git', branch: 'main',
credentialsId: 'aws-developer'
          }
}

//INFRA iS CODE


   stage('TF INICIAR') {
         steps {
           sh 'terraform init -reconfigure'
                
          }
     }

    stage('TF FMT') {
         steps {
              sh 'terraform fmt'
                
          }
       }

      stage('TF destroy') {
           steps {
        sh 'terraform destroy -auto-approve'
           }
    }
	
        }
}