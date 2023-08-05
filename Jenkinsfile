pipeline {
    agent node { {  label 'ubuntu' } }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS secret access ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS sceret access key')
        DOCKER_CRED = credentials('Docker')
    }

    stages {
        stage ('build') {
            when {
                equals(actual: currentBuild.number, expected: 1)
            }
            steps {
                sh './build.sh'         
            }
        }

        stage ('push') {
            when {
                equals(actual: currentBuild.number, expected: 1)
            }
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
            when {
                equals(actual: currentBuild.number, expected: 1)
            }
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

