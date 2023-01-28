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
credentialsId: 'jenkins-server_local'
          }
}

stage('Slack Notification(Terraform Start Process)') {
steps {
slackSend message: 'Agora está iniciando processo de construção da infra-estrutura da AWS. O commando "terraform fmt" , vai atualizar somente oque foi alterado ou adicionado ao projeto!'
}
}

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

stage('TF APPLY') {
 steps {
 sh 'terraform apply -auto-approve'
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

post {
        // Send the build result to slack channel
        success {
          slackSend (color:'good', message: "<@$userIds>Successfully deployed")
        }
        failure {
            slackSend (color:'danger', message: "<@$userIds>Error in build ${env.JOB_NAME}")
        }
    }
       
}
}


