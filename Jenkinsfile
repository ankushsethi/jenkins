pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Build') {
      parallel {
        stage('Build on Master') {
          agent {
            node {
              label 'master'
            }

          }
          steps {
            echo 'Building Source Code'
            sh '''curl -s -O https://raw.githubusercontent.com/ankushsethi/jenkins/refs/heads/main/install_jmeter.sh
chmod +x install_jmeter.sh
./install_jmeter.sh'''
          }
        }

        stage('Build on Node1') {
          agent {
            node {
              label 'node1'
            }

          }
          steps {
            echo 'Building on Node1'
            sh '''curl -s -O https://raw.githubusercontent.com/ankushsethi/jenkins/refs/heads/main/install_jmeter.sh
chmod +x install_jmeter.sh
./install_jmeter.sh'''
          }
        }

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
        sh 'git clone https://github.com/ankushsethi/jenkins.git'
      }
    }

    stage('Test Runs') {
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

    stage('Smoke Test Report') {
      agent {
        node {
          label 'master'
        }

      }
      steps {
        echo 'Sending Reports To Tester'
      }
    }

    stage('Regression Test Report') {
      agent {
        node {
          label 'node1'
        }

      }
      steps {
        echo 'Sending Report To Tester'
      }
    }

  }
}