pipeline {
  agent any
  stages {
    stage('Smoke Test') {
      parallel {
        stage('Smoke Test') {
          steps {
            echo 'Executing Smoke Test'
          }
        }

        stage('Regression Test') {
          steps {
            echo 'Executing Regression Test'
          }
        }

      }
    }

  }
}