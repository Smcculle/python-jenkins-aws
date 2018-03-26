pipeline {
    agent { 
        docker { 
            image 'python:2-alpine'
        }
    }

    environment {
        VIRTUAL_ENV = "${env.WORKSPACE}/venv"
    }

    stages {

        stage('Prep') {
            steps {
                sh """
                    pip install virtualenv
                    virtualenv venv
                    export PATH=${VIRTUAL_ENV}/bin:${PATH}
                    pip install --upgrade pip
                    pip install -r requirements.txt
                """
                //sh'pip install --upgrade pip'
                //sh 'pip install --user jenkins -r requirements.txt'
               // sh 'mkdir reports'
            }
        }

        stage('Verify') {
            steps {
                sh 'pylint --reports=y sources/ > test-reports/pylint-report'
                sh 'pytest --pep8 --html=test-reports/pep8-report.html --self-contained-html'
            }
        }
 
        stage('Build') {
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
            }
        }

        stage('Test') {
           steps {
                sh 'pytest --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') { 
            steps {
                sh 'pyinstaller --onefile sources/add2vals.py' 
            }
            post {
                success {
                    archiveArtifacts 'dist/add2vals' 
                    archiveArtifacts 'test-reports/pylint-report' 
                    archiveArtifacts 'test-reports/pep8-report.html' 
                }
            }
        }
    }
}
