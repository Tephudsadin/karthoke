pipeline {
    agent {
        docker {
            image 'python:3.7.4-alpine3.9'
        }
    }
    environment {
        TZ = 'Asia/Bangkok' 
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
                sh 'apk update \
                    &&  apk add ca-certificates wget tzdata\
                    &&  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
                    &&  echo $TZ > /etc/timezone \
                    &&  apk add --no-cache firefox-esr \
                    &&  update-ca-certificates \
                    &&  wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz \
                    &&  tar -xvzf geckodriver* \
                    &&  chmod +x geckodriver \
                    &&  mv geckodriver /usr/local/bin/'
            }
        }

        stage('Run') {
            steps {
                sh 'ls -l'
                sh 'robot -d Result -t Report18 Report.robot || echo test'
                sh 'ls -l'
                archiveArtifacts artifacts: '**/Result/**/*', excludes: '**/Result/**/*.xml'
            }
        }

    }

    post {
        always {
            deleteDir()
        }
    }
}