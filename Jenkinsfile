pipeline {
    agent none 
    stages {

        stage('Testing') {
        sh 'whoami' 
        }

        stage('Build') { 
            agent {
                docker {
                    image 'python:2-alpine' 
                }
            }
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py' 
            }
        }
    }
}