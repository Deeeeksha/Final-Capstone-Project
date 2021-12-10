pipeline{
    agent any
    options{
        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
        timestamps()
    }
    stages{
        
        // stage("Clean")
        // {
        //     steps
        //     {
        //         sh 'mvn clean'
        //     }
        // }
        // stage("Compile")
        // {
        //     steps
        //     {
        //         sh 'mvn compile'
        //     }
        // }
        stage("Test")
        {
            when
            {
                branch 'Testing'   
            }
            steps
            {
                // sh 'mvn test'
                sh 'echo hello'
            }
        }
        stage("Push to DockerHub")
        {
            when
            {
                branch 'Production'   
            }
            stages
            {
                stage("Push to DockerHub")
                {
                    steps
                    {
                        sh'''
                        echo "Pushed To DockerHub"
                        '''
                    }
                } 
                stage("Deploy To Kubernetes")
                {
                    steps
                    {
                        sh'''
                        echo "Deployed"
                        '''
                    }
                }   
            }
        }
        
    }
    post{

        always
        {
            emailext attachLog: true, body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'dipayan.pramanik@knoldus.com'  
        }
        success{
            cleanWs()
        }
    }
}