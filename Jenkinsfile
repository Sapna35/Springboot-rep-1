pipeline {
    agent any

    environment {
        APP_SERVER = "13.39.159.254"   
        APP_USER   = "ubuntu"
        GIT_REPO   = "https://github.com/Sapna35/Springboot-rep-1.git"
        POM_DIR    = "Springboot-rep-1"   
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                // Go into directory where pom.xml exists
                dir("${POM_DIR}") {
                    withMaven(maven: 'Maven-3.9.6') {
                        sh 'mvn clean package -DskipTests'
                    }
                }
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-server-key']) {
                    // Copy the JAR and run it on remote server
                    sh """
                        scp -o StrictHostKeyChecking=no ${POM_DIR}/target/*.jar $APP_USER@$APP_SERVER:/home/$APP_USER/app.jar
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
