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
            sh '''mkdir -p /home/jenkins/jmeter
cd /home/jenkins/jmeter
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
        sh '''rm -rf jenkins
git clone https://github.com/ankushsethi/jenkins.git'''
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh """
                                            ${SONARQUBE_SCANNER_HOME}/bin/sonar-scanner \
                                            -Dsonar.projectKey=jenkins \
                                            -Dsonar.sources=. \
                                            -Dsonar.host.url=http://192.168.1.31:9000 \
                                            -Dsonar.login=sqa_f69ecb943fcd80837261e68a0245ab4a8a3dc93e \
                                            """
        }

      }
    }

    stage('Quality Gate') {
      steps {
        waitForQualityGate()
        script {
          timeout(time: 5, unit: 'MINUTES') {
            def qg = waitForQualityGate() // This checks the SonarQube Quality Gate result
            if (qg.status != 'OK') {
              error "Pipeline aborted because Quality Gate failed: ${qg.status}"
            }
          }
        }

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
            sh 'sh /home/jenkins/jmeter/apache-jmeter-5.6.3/bin/jmeter.sh -n -t /var/jenkins_home/workspace/jenkins_main/jmeter_script.jmx -l /var/jenkins_home/workspace/jenkins_main/Smoke_Test.jtl'
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
            sh 'sh /home/jenkins/jmeter/apache-jmeter-5.6.3/bin/jmeter.sh -n -t /home/jenkins/agent/workspace/jenkins_main/jmeter_script.jmx -l /home/jenkins/agent/workspace/jenkins_main/Regression_Test.jtl'
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

    stage('Notify Stakeholders') {
      agent any
      steps {
        emailext(subject: 'Pipeline Status', to: 'ankush.sethi@epam.com', from: 'admin@jenkins.org', body: 'Pipeline Passed')
      }
    }

  }
  environment {
    SONARQUBE_SCANNER_HOME = 'SonarQube Scanner'
  }
}