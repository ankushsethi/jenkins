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
            sh '''mkdir -p /opt/jmeter
cd /opt/jmeter
curl -O https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
tar -xzf apache-jmeter-5.6.3.tgz
rm apache-jmeter-5.6.3.tgz'''
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
            sh '''mkdir -p /home/jenkins/jmeter
cd /home/jenkins/jmeter
curl -O https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
tar -xzf apache-jmeter-5.6.3.tgz
rm apache-jmeter-5.6.3.tgz'''
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