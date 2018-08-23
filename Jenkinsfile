node {
  //cleanWs()

    stage('Preparation') { // for display purposes
        // Get some code from a GitHub repository

    checkout([$class: 'GitSCM', branches: [[name: '**/ready/**']], 
    doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout'], 
    pretestedIntegration(gitIntegrationStrategy: accumulated(), integrationBranch: 'master', 
    repoName: 'origin')], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'thevinge', 
    url: 'git@github.com:Vedsted/ca-project.git']]])
    
 //   stash name: "repo", includes: "**", useDefaultExcludes: false
    }
    
    stage('Unit-Tests') {
        // Run the maven build
        if (isUnix()) {
         sh 'docker pull vedsted/codechan:latest-base'
         sh 'docker run -i --rm --name codechan_Test_Script -v $PWD:/usr/src/codechan -w /usr/src/codechan vedsted/codechan:latest-base python tests.py'
         //  sh 'docker-compose up -d python tests.py'
            //sh "mvn -Dmaven.test.failure.ignore clean package"
//            stash name: "build-result", includes: "target/**"

        }
    }
    stage('Push-VC'){
        pretestedIntegrationPublisher()

        deleteDir()
    }
    stage('Deploy image'){
        sh 'deployment/deploy_image.sh'
    }
  
}
