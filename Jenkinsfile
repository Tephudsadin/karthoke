pipeline {
    agent {
        docker { image 'python:3.7.4-windowsservercore-1809'}
    }

    stages {

        stage('clone git repository') {
            steps {
                bat 'dir'
            }
        }

        stage('Install') {
            steps {
                bat 'pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib robotframework robotframework-seleniumlibrary restinstance'
            }
        }

        stage('Run') {
            steps {
                bat 'dir'
                bat 'robot -d Result -t Report22 Report.robot'
                bat 'dir'
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