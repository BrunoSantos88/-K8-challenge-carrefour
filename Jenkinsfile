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

stage('Sonar(SNYK)SAST') {
            steps {		
				withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
					sh 'mvn snyk:test -fn'
				}
			}
    }

	//Docker 
stage('DockerBuild') {
  steps {
    sh 'docker build -t brunosantos88/awsfrontend:v2 frontend/.'
    sh 'docker build -t brunosantos88/awsbackend:v2 backend/.'
  }
  }

stage('DockerLogin') {
  steps {
    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
  }
  }
   
stage('DockerPushFrontend') {
  steps {
    sh 'docker push brunosantos88/awsfrontend:v2'
  }
  }

stage('DockerPushbackend') {
  steps {
   sh 'docker push brunosantos88/awsbackend:v2'


}
}

stage ('SQL Test') {
node('remote_node') {
def sql = Sql.newInstance("jdbc:mysql://DBHOST/DBSCHEMA",
"DBUSER", "DBPASSWORD", "com.mysql.jdbc.Driver")
query = "SELECT * from myTable"
println sql.rows(query)
sql.close()
}
}

stage('Kubernetes Deployment(Services)') {
	steps {
	  withKubeConfig([credentialsId: 'kubelogin']) {
    sh ('kubectl create namespace developer')
		sh ('kubectl apply -f frontend.yaml --namespace=developer')
    sh ('kubectl apply -f backend.yaml --namespace=developer')
     sh ('kubectl apply -f database.yaml --namespace=developer')
	}
	}
  }

//Teste DAST para os serviçoes kuberntes
stage ('AGUARDAR OWSZAP(DAST)'){
	steps {
    sh 'pwd; sleep 180; echo "Application Has been deployed on K8S"'
	}
	}
	   

 stage('OWSZAPSONAR(DAST)') {
  steps {
	  withKubeConfig([credentialsId: 'kubelogin']) {
	  sh('zap.sh -cmd -quickurl http://$(kubectl get services/frontend --namespace=developer -o json| jq -r ".status.loadBalancer.ingress[] | .hostname") -quickprogress -quickout ${WORKSPACE}/zap_report.html')
	  archiveArtifacts artifacts: 'zap_report.html'
	}
	}
  } 


}
}