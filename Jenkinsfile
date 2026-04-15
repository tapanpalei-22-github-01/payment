pipeline {
    agent any

	environment {
        REGISTRY = "ghcr.io"
        REPO = "tapanpalei-22-github-01/payment"
        IMAGE_TAG = "1.0"
    }

    stages {
        stage('Check Branch') {
            when {
                branch 'main'
            }
            steps {
                echo "Running pipeline on main branch"
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

		stage('Docker Build') {
            steps {
                sh 'docker build -t $REGISTRY/$REPO:$IMAGE_TAG .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'GithubCred', usernameVariable: 'USERNAME', passwordVariable: 'TOKEN')]) {
                    sh 'echo $TOKEN | docker login $REGISTRY -u $USERNAME --password-stdin'
                    sh 'docker push $REGISTRY/$REPO:$IMAGE_TAG'
                }
            }
        }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         sh 'kubectl apply -f k8s/deployment.yaml'
        //         //sh 'kubectl apply -f k8s/order-service.yaml'
        //         sh 'kubectl apply -f k8s/payment-service.yaml'
        //     }
        // }

        stage('Kubernetes Deploy') {
            steps {
                withCredentials([file(credentialsId: 'docker-desktop-kubeconfig', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl --kubeconfig $KUBECONFIG apply -f k8s/deployment.yaml
                        kubectl --kubeconfig $KUBECONFIG apply -f k8s/payment-service.yaml
                    '''
                }
            }
        }

        stage('Verify') {
            steps {
                withCredentials([file(credentialsId: 'docker-desktop-kubeconfig', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl --kubeconfig $KUBECONFIG get pods
                        kubectl --kubeconfig $KUBECONFIG get svc
                    '''
                }
            }
        }

	}
}