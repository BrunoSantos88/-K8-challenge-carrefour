pipeline{
  agent any

  tools { 
        ///depentencias 
        maven 'Maven 3.6.3' 
        terraform 'Terraform 1.3.7' 
}
        environment {
        //Chaves
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        DOCKERHUB_CREDENTIALS = credentials('dockerlogin')
}

stages {   

stage('GIT CLONE') {
  steps {
   // Get code from a GitHub repository
    git url: 'https://github.com/BrunoSantos88/-K8-challenge-carrefour.git', branch: 'main',
    credentialsId: 'jenkins-server_local'
  }
  }


//TEST SAST 
stage('SynkSonar(SAST)') {
  steps {		
		withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
		sh 'mvn snyk:test -fn'
	}
	}
  }

  //Terraform
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

stage('TF Apply') {
  steps {
    sh 'terraform apply -auto-approve'
  }
  }

//Email Notification
post {
always {
echo "Notifying build result by email"
  }
success {
mail to: 'infratidevops@gmail.com',
subject: "SUCCESS: ${currentBuild.fullDisplayName}",
body: "Pipeline passou, Efetou com Sucesso"

  }
failure {
mail to: 'infratidevops@gmail.com',
subject:"FAILURE: ${currentBuild.fullDisplayName}",
body: "Pipeline Falhou , verificar os parametros corretos!"
  }
  }
  
}
}


