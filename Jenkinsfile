pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        node {
          label 'master'
        }

      }
      steps {
        echo 'Building Source Code'
      }
    }

    stage('Checkout') {
      agent {
        node {
          label 'master'
        }

      }
      steps {
        echo 'Checkout Code'
      }
    }

    stage('Smoke Test') {
      parallel {
        stage('Smoke Test') {
          agent {
            node {
              label 'master'
            }

          }
          steps {
            echo 'Executing Smoke Test'
          }
        }

        stage('Regression Test') {
          agent {
            node {
              label 'node1'
            }

          }
          steps {
            echo 'Executing Regression Test'
          }
        }

      }
    }

    stage('Reports') {
      parallel {
        stage('Smoke Test Report') {
          steps {
            echo 'Sending Reports To Tester'
          }
        }

        stage('Regression Test Report') {
          steps {
            echo 'Sending Report To Tester'
          }
        }

      }
    }

  }
}