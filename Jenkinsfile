pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS secret access ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS sceret access key')
        DOCKER_CRED = credentials('Docker')
         GIT_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }

    stages {
        stage ('build') {
            steps {
                sh './build.sh'         
            }
        }

        stage ('push') {
            steps{ 
               sh ' ./push.sh '
            }
        }

        stage ('create') {
            //when {
              //  changelog 'main.tf'
            //}
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./create.sh  "
                    }
               }
            }
        }

        stage ('deploy') {
            steps{
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./deploy.sh  "
                    }
               }
            }
        }

        stage ('monitor') {
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./monitor.sh  "
                    }
               }
            }
        }
    }
}

        

