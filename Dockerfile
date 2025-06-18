pipeline {
    agent {
        docker {
            image 'android-ci'
            args '-v $HOME/.gradle:/root/.gradle'  // Cache gradle
        }
    }

    environment {
        GRADLE_OPTS = "-Dorg.gradle.daemon=false"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/android-app.git'
            }
        }

        stage('Build APK') {
            steps {
                sh './gradlew assembleRelease'
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'app/build/outputs/apk/release/*.apk', allowEmptyArchive: false
            }
        }
    }
}
