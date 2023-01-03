pipeline {
    agent any
   /* Install app dependencies and build if you have build script */ 
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                /* sh 'npm run build' */
            }
        }

       /* Run Tests If you have Test Scripts 
       stage ('Test') {
            steps {
                sh 'npm test'
            }
        } */
        /* Archive the build */

        stage ('Archive') {
            steps {
                sh '''
                cd /var/lib/jenkins/workspace/Todo-Nodejs-Pipeline-AWS
                zip -r Todo-Nodejs.zip *
                '''
            }
        }
        /* Transfer Build to respectivePROD or DEV Node */
        stage ('Transfer Build To Production Node') {
            steps {
                sh 'scp -o StrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa /var/lib/jenkins/workspace/Todo-Nodejs-Pipeline-AWS/Todo-Nodejs.zip ubuntu@172.31.87.197:/home/ubuntu/Todo-Nodejs.zip'
            }    
        }
        /* Extract Project Files on Node */
        stage ('Extract Project Files on Production Node') {
        agent {label 'PROD-NODE'}
            steps {
                sh 'unzip -o ~/Todo-Nodejs.zip -d ~/Todo-Nodejs' 
            }       
        }
        /* Start App Process In Prod Or Dev Enviroment */
        stage ('Deploy App in Production') {
        agent {label 'PROD-NODE'}
            steps {
                sh '''
                cd /home/ubuntu/Todo-Nodejs
                pm2 start app.js -n "Todo-App-PROD"
                pm2 save
                '''
            }
        }
    }
}   