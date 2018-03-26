pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('Prep') {
      agent any
      steps {
        sh 'echo "Prep finished"'
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