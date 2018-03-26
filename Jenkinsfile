pipeline {
    agent { dockerfile true }
      
    stages {
        stage('Prep') {
            steps { sh 'mkdir test-reports; ls'}
      }

        stage('Verify') {
            steps {
                # most python testing tools output any results to stderr, which stops the pipeline, so we add || true to continue
                sh 'pylint --reports=y sources/ > test-reports/pylint-report 2> /dev/null || true'
                sh 'pytest --pep8 --html=test-reports/pep8-report.html --self-contained-html > /dev/null 2>&1 || true'
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
                always { junit 'test-reports/results.xml'}
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
