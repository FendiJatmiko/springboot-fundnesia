pipeline {
  agent any
  stages {
    stage('Deploy...') {
      when {
        branch 'master'
      }
      steps {
        echo 'Deploying apps spring-boot....'
        sh 'docker build -t fendijatmiko/springboot:${BUILD_NUMBER} .'
        sh 'docker-compose up -d'
      }
    }
  }
}


