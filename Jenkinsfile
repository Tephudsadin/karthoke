pipeline {
    agent {
        docker { image 'python:3.7.4-alpine3.9'}
    }

    stages {

        stage('clone git repository') {
            steps {
                sh 'ls -l'
            }
        }

        stage('Install') {
            steps {
                sh 'pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib robotframework robotframework-seleniumlibrary restinstance'
            }
        }

        stage('Run') {
            steps {
                sh 'robot -d Result -t Report22 report.robot'
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