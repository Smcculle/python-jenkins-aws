pipeline {
  agent none
  environment {
    TEST_DIR='test-reports'
  }
  stages {
    stage('Prep') {
      agent { dockerfile 'true' }
      steps {
        sh 'mkdir ${TEST_DIR}' 
      }
    }
    stage('Verify') {
      parallel {
        stage('Lint') {
      agent { 
        dockerfile { reuseNode true }
      } 
          steps {
            sh 'ls -a'
            sh "mkdir ${TEST_DIR}"
            sh "pylint --reports=y sources/ > ${TEST_DIR}/pylint-report 2> /dev/null || true"
            sh "pytest --pep8 --html=${TEST_DIR}/pep8-report.html --self-contained-html > /dev/null 2>&1 || true"
            sh "ls ${TEST_DIR}/"
          }
          post {
            always {
             archiveArtifacts "${TEST_DIR}/pylint-report"
             archiveArtifacts "${TEST_DIR}/pep8-report.html"
             }
           }
        }

        stage('Syntax') {
          agent { 
            dockerfile { reuseNode true }
          }
          steps {
            sh 'python -m py_compile sources/*.py'
          }
        }

        stage('Test') {
          agent { 
            dockerfile { reuseNode true }
          } 
          steps {
            sh "mkdir ${TEST_DIR}"
            sh "pytest --verbose --junit-xml ${TEST_DIR}/results.xml sources/test_calc.py || true "
          }
          post { 
            always { junit "${TEST_DIR}/results.xml" }
          }
        }
      }
    }
    stage('Deliver') {
      agent {
        docker { image 'cdrx/pyinstaller-linux:python2' } 
      }
      steps {
        sh 'pyinstaller --onefile sources/add2vals.py'
      }
      post {
        success {
          archiveArtifacts 'dist/add2vals'
        }
        
      }
    }
  }
}
