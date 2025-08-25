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
                    // SCP the jar to the server
                    sh "scp target/simple-hello-Sapna-1.0.0.jar ${APP_USER}@${APP_SERVER}:/home/ubuntu/"
                    
                    // Run the jar on the remote server
                    sh "ssh ${APP_USER}@${APP_SERVER} 'nohup java -jar /home/ubuntu/simple-hello-Sapna-1.0.0.jar > /home/ubuntu/app.log 2>&1 &'"
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
