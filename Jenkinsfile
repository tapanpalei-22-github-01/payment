pipeline {
    agent any

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
	}
}