pipeline {
    agent any

    stages {

        stage('clone git repository') {
            steps {
                sh 'ls -l'
            }
        }

    }

    // post {
    //     always {
    //         script {
    //             sh "docker rmi ${DOCKER_REGISTRY}/${DOCKER_IMG_NAME}:${DOCKER_TAG} || echo 'ignore'"
    //         }
    //         deleteDir()
    //     }
    // }
}