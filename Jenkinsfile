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
                echo "Deploying jar to ${APP_USER}@${APP_SERVER}..."
                
                # Copy the jar to the remote server
                scp -o StrictHostKeyChecking=no target/simple-hello-Sapna-1.0.0.jar ${APP_USER}@${APP_SERVER}:/home/ubuntu/
                
                # Run the jar in the background on the remote server
                ssh -o StrictHostKeyChecking=no ${APP_USER}@${APP_SERVER} 'nohup java -jar /home/ubuntu/simple-hello-Sapna-1.0.0.jar > /home/ubuntu/app.log 2>&1 &'
                
                echo "Deployment completed."
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
