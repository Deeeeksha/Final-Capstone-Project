pipeline{
    agent any
    options{
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
        timestamps()
    }
    environment{
        
        image_built=''
        image_tag='dipayanp007/capstone:${GIT_COMMIT}-build-${BUILD_NUMBER}'
        
    }
    tools{
        maven 'maven'
        jdk 'jdk'
    }
    stages{
        
        stage("Cleaning up the workspace")
        {
            steps
            {
                sh 'mvn clean'
            }
        }
        stage("Compile the code")
        {
            steps
            {
                sh 'mvn compile'
            }
        }
        stage("Testing the application")
        {
            when
            {
                branch 'Testing'   
            }
            steps
            {
                sh 'mvn test'          
            }
        }
        stage("Packaging, pushing to DockerHub and deploying to Kubernetes Cluster")
        {
            when
            {
                branch 'Production'   
            }
            stages
            {
                stage("Packaging the application into executable jar")
                {
                    steps
                    {
                        sh 'mvn package'
                    }
                }
            
                stage("Building the docker image")
                {
                    steps
                    {
                        script
                        {
                            image_built=docker.build image_tag
                    
                        }
                    }
                } 
                stage("Push the Image to DockerHub")
                {
                    steps
                    {
                        script
                        {
                            docker.withRegistry('', 'DockerHub')
                            {
                                image_built.push()
                                image_built.push('latest')
                            }
                        }
                    }
                }
                stage("Deploy To Kubernetes")
                {
                    steps
                    {
                        sh 'echo Deploy'
                    }
                }   
            }
        }
        
    }
    post{

        failure
        {
            emailext attachLog: true, body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'dipayan.pramanik@knoldus.com'  
        }
        success{
            archiveArtifacts allowEmptyArchive: true, artifacts: '**/*.jar', excludes: '.mvn/*', onlyIfSuccessful: true
            cleanWs()
        }
        always{
            sh 'docker logout'
        }
    }
}