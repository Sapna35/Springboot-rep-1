pipeline {
    agent any

    environment {
        APP_SERVER = "13.39.159.254"   
        APP_USER   = "ubuntu"
        GIT_REPO   = "https://github.com/Sapna35/Springboot-rep-1.git"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                withMaven(maven: 'Maven-3.9.6') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-server-key']) {
                    scp target/simple-hello-Sapna-1.0.0.jar ubuntu@13.39.159.254:/home/ubuntu/
                    sh 'ssh ubuntu@your-server "java -jar /home/ubuntu/simple-hello-Sapna-1.0.0.jar &"'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
