pipeline {
    agent none 
    stages {

        stage('Testing') {
            agent any
            steps {
            sh 'uname -a'
            sh 'groups'
            }
        }
        stage('Build') { 
            agent {
                docker {
                    image 'hello-world:latest' 
                }
            }
            steps {
//                sh 'python -m py_compile sources/add2vals.py sources/calc.py' 
                echo 'hi from hello world'
            }
        }
    }
}
