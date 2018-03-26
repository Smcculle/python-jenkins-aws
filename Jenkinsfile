pipeline {
  agent none
  stages {
    stage('Prep') {
      agent {
        dockerfile {
          filename 'Dockerfile'
        }
      }
      steps {
        sh 'mkdir test-reports; ls'
      }
    }
    stage('Verify') {
      parallel {
        stage('Lint') {
          agent {
            dockerfile {
              filename 'Dockerfile'
            }
            
          }
          steps {
            sh 'pylint --reports=y sources/ > test-reports/pylint-report 2> /dev/null || true'
            sh 'pytest --pep8 --html=test-reports/pep8-report.html --self-contained-html > /dev/null 2>&1 || true'
          }
          post {
            always {
             archiveArtifacts 'test-reports/pylint-report'
             archiveArtifacts 'test-reports/pep8-report.html'
             }
           }
        }

        stage('Syntax') {
          agent {
            dockerfile {
              filename 'Dockerfile'
            }
            
          }
          steps {
            sh 'python -m py_compile sources/add2vals.py sources/calc.py'
          }
        }

        stage('Test') {
          agent {
            dockerfile {
              filename 'Dockerfile'
            }
            
          }
          steps {
            sh 'pytest --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
          }
          post { 
            always { junit 'test-reports/results.xml' }
          }
        }
      }
    }
    stage('Deliver') {
      agent {
        docker {
          image 'cdrx/pyinstaller-linux:python2'
        }
        
      }
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
