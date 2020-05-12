pipeline {
    agent any

    environment {
        GIT_URL = 'git@github.com:FendiJatmiko/springboot-fundnesia.git'
        AWS_REGION = 'ap-southeast-1'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        ECS_CLUSTER_NAME = 'fundnesia'

    }

    stages {

        stage('checkout') {
            steps {
                deleteDir()
                git branch: 'master',
                        url: "${GIT_URL}"
            }
        }

        stage('prepare environment') {
            steps {
                script {
                    DOCKER_IMAGE_NAME = sh(
                        returnStdout: true,
                        script: 'cat docker-compose.yml | docker run -i --rm fendijatmiko/spring-boot get -r .services.spring-boot.image'
                    ).trim()

                    DOCKER_IMAGE_AND_TAG = "${DOCKER_IMAGE_NAME}:v_${BUILD_NUMBER}"

                    echo " === updating tag in docker-compose.yml === "
                    sh "cat docker-compose.yml | docker run -i --rm fendijatmiko/spring-boot set .services.spring-boot.image \\\"${DOCKER_IMAGE_AND_TAG}\\\" | tee upd-docker-compose.yml"
                }
            }
        }


        stage('build jar') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('build docker image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}") {
                        container = docker.build("${DOCKER_IMAGE_AND_TAG}")
                        container.push()
                    }
                }
            }
        }

        stage('deploy to ecs') {
            steps {
                sh '''#!/bin/sh -e

                    echo " === Configuring ecs-cli ==="
                    /usr/local/bin/ecs-cli configure --region ${AWS_REGION} --cluster ${ECS_CLUSTER_NAME}

                    echo " === Create/Update Service === "
                    /usr/local/bin/ecs-cli compose --file upd-docker-compose.yml service up \
                    --deployment-min-healthy-percent 0 \
                    --container-name spring-boot-fundnesia \
                    --container-port 8000 \

                ''' // end shell script
            }
        }
    }

}
