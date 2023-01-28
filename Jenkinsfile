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

stage('GIT CLONE') {
steps {
                // Get code from a GitHub repository
git url: 'https://github.com/BrunoSantos88/-K8-challenge-carrefour.git', branch: 'main',
credentialsId: 'aws-developer'
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

	stage('SOCKER PUSH FRONTEND') {
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

	stage('Docker PUSH BACKEND') {
            steps {
                script{
                    docker.withRegistry('https://555527584255.dkr.ecr.us-east-1.amazonaws.com', 'ecr.us-east-1:aws-credentials') {
                    app.push("v1")
                    }
                }
}


}
}
}



