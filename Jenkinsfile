pipeline {
  agent any
  stages {
    stage('Deploy...') {
      when {
        branch 'master'
      }
      steps {
        echo 'Deploying apps spring-boot....'
        sh 'docker build --no-cache -t fendijatmiko/springboot:${BUILD_NUMBER} .'
        sh 'docker push fendijatmiko/springboot:${BUILD_NUMBER}'
        sh 'docker-compose up -d'
      }
    }
  }
}


