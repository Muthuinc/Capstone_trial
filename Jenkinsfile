pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS secret access ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS sceret access key')
        DOCKER_CRED = credentials('Docker')
    }

    stages {
        stage ('build') {
            steps {
                sh './build.sh'         
            }
        }

        stage ('push') {
            steps{ 
               sh ' ./build.sh '
            }
        }

        stage ('create') {
            when {
                changelog 'main.tf'
            }
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./create.sh '$SSH_KEY' "
                    }
               }
            }
        }

        stage ('deploy') {
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./deploy.sh '$SSH_KEY' "
                    }
               }
            }
        }
    }
}

        //stage ('monitor') {
        //    when {
        //        changelog 'blackbox.yml'
        //    }
        //    steps{ 
        //       script {
        //            withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
        //                sh "./monitor.sh '$SSH_KEY' "
        //            }
        //       }
        //    }
        //}

