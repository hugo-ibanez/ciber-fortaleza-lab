pipeline {
    agent any
    environment {
        IMAGE_NAME = "bioguard-app"
        CONTAINER_NAME = "bioguard-container"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Test & QA (PyBuilder)') {
            steps {
                echo "Iniciando auditoria de calidad con PyBuilder..."
                sh 'pip install pybuilder'
                sh 'pyb'
            }
        }
        stage('Build Image') {
            steps {
                echo "Construyendo imagen de Docker..."
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage('Deploy Seguro') {
            steps {
                echo "Desplegando en puerto seguro 8443..."
                // Limpiamos contenedores previos si existen
                sh "docker rm -f ${CONTAINER_NAME} || true"
                // MODIFICACIÓN: Puerto seguro 8443 mapeado al 5000 interno
                sh "docker run -d -p 8443:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
            }
        }
    }
    post {
        success {
            echo 'Operación Ciber-Fortaleza: Fase 3 Completada con éxito!'
        }
        failure {
            echo 'El build ha fallado. Revisa la cobertura de PyBuilder o los logs de Docker.'
        }
    }
}