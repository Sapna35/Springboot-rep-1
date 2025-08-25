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
                    sh """
                        scp -o StrictHostKeyChecking=no target/*.jar $APP_USER@$APP_SERVER:/home/$APP_USER/app.jar
                        ssh -o StrictHostKeyChecking=no $APP_USER@$APP_SERVER "pkill -f app.jar || true; nohup java -jar /home/$APP_USER/app.jar > /home/$APP_USER/app.log 2>&1 &"
                    """
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
