pipeline {
    agent any
    
    environment {
        PROJECT_ID = 'advance-display-419312 '
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        IMAGE_NAME = "gcr.io/${PROJECT_ID}/frontend:${IMAGE_TAG}"
        CHART_NAME = 'frontend'
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
        
        stage('Push to GCR') {
            steps {
                sh "gcloud auth configure-docker"
                sh "docker push $IMAGE_NAME"
            }
        }
        
        stage('Deploy to GKE') {
            steps {
                withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh "gcloud container clusters get-credentials your-cluster-name --zone us-central1 --project $PROJECT_ID"
                    sh "helm upgrade --install $CHART_NAME ./frontend --set image.repository=$IMAGE_NAME,image.tag=$IMAGE_TAG"
                }
            }
        }
    }
}
