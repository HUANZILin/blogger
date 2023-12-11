// pipeline {
//     agent {
//         node {
//             label '410977006'
//         }
//     }
//     options {
//         skipDefaultCheckout(true)
//     }
//     stages {
//         stage('Clean old DOCs & chekcout SCM') {
//             steps {
//                 echo 'Cleaning old DOCs and checking out SCM...'
//                 cleanWs()
//                 checkout scm
//             }
//         }
//         stage('Verify tools') {
//             steps {
//                 echo 'Verifying Docker, Docker Compose, and Composer versions...'
//             }
//         }
//         stage('Start Container') {
//             steps {
//                 echo 'Starting the Docker containers...'
//             }
//         }
//         stage('Dependency installation') {
//             steps {
//                 echo 'Installing dependencies...'
//             }
//         }
//         stage('Environment Setting Up') {
//             steps {
//                 echo 'Setting up the environment...'
//             }
//         }
//         stage('Database migrate') {
//             steps {
//                 echo 'Running database migration...'
//             }
//         }
//         stage('Database seed') {
//             steps {
//                 echo 'Seeding the database...'
//             }
//         }
//         stage('Unit testing') {
//             steps {
//                 echo 'Running unit tests...'
//                 // junit 'app/build/logs/blogger_unitTest.xml'
//             }
//         }
//     }
//     post {
//         always {
//             echo 'Cleaning up Docker containers...'
//         }
//     }
// }

pipeline{
  agent{
    node{
      label '410977006'
    }
  }
  environment{
    DOCKERHUB_CREDENTIALS = credentials('410977006-dockerhub')
  }
  options {
      skipDefaultCheckout(true)
  }
  stages{
    stage('Clean old DOCs & checkout SCM'){
      steps{
        echo 'Successfully clean old DOCs & chekcout SCM.'
      }
    }
    stage('verify tools'){
     steps{
       sh '''
       echo 'Verifying Docker, Docker Compose, and Composer versions...'
       '''
     }  
    }
    stage('Login Dockerhub'){
      steps{
        sh '''
          echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        '''
      }
    }
    stage('Build image for application'){
      steps{
        sh '''
          docker build
        '''
      }
    }
    stage('Rename && Push image to Dockerhub'){
      steps{
        sh '''
          docker tag  410977006_pipeline_ci4_service:latest 410977006-dockerhub/410977006_pipeline_ci4_service:latest
          docker push 410977006-dockerhub/410977006_pipeline_ci4_service:latest
        '''
      }
    }
    stage('Start Container'){
      steps{
        sh '''
           docker-compose up
        '''
      }
    }
    stage('Check Container'){
      steps{
        sh '''
           docker ls
        '''
      }
    }
   }
   post {
        always {
          sh '''
          docker-compose down
          docker system prune -a -f
          docker logout
          '''
        }
      }
}