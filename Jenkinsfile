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
//DOCKERHUB_CREDENTIALS = credentials('dockerlogin')
}

//Stages.
stages {   

stage('Slack Notification(Start)') {
steps {
slackSend message: 'Pipeline Inciada!. Necessidade de atenção, caso seja em Produção!'

}
}

  
stage('GIT CLONE') {
steps {
                // Get code from a GitHub repository
git url: 'https://github.com/BrunoSantos88/-K8-challenge-carrefour.git', branch: 'main',
credentialsId: 'aws-developer'
          }
}

stage('Slack Notification(Terraform Start Process)') {
steps {
slackSend message: 'Agora está iniciando processo de construção da infra-estrutura da AWS. O commando "terraform fmt" , vai atualizar somente oque foi alterado ou adicionado ao projeto!'
}
}

stage('Sonar(SNYK)SAST') {
            steps {		
				withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
					sh 'mvn snyk:test -fn'
				}
			}
    }

	stage('DOCKER BUILD FRONTEND') { 
            steps { 
               withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
                 script{
                 app =  docker.build("frontend frontend/")
                 }
               }
            }
    }

	stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://555527584255.dkr.ecr.us-east-1.amazonaws.com', 'ecr.us-east-1:aws-credentials') {
                    app.push("v1")
                    }
                }
}
}

stage('DOCKER BUILD BACKEND') { 
            steps { 
               withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
                 script{
                 app =  docker.build("backend backend/.")
                 }
               }
            }
    }

	stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://555527584255.dkr.ecr.us-east-1.amazonaws.com', 'ecr.us-east-1:aws-credentials') {
                    app.push("v1")
                    }
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
}


