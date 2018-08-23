node('non_privileged') {
  //cleanWs()

    stage('Preparation') { // for display purposes
        // Get some code from a GitHub repository

    checkout([$class: 'GitSCM', branches: [[name: '**/ready/**']], 
    doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout'], 
    pretestedIntegration(gitIntegrationStrategy: accumulated(), integrationBranch: 'master', 
    repoName: 'origin')], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'thevinge', 
    url: 'git@github.com:Vedsted/ca-project.git']]])
    
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
        stash name: "repo", includes: "**", useDefaultExcludes: false
 
    }

}

node('deployment_test'){
    stage('Deploy -test'){
        unstash 'repo'
        sh 'docker pull vedsted/codechan:latest-base'
        sh 'docker run -i --rm --name codechan_Test_Script -v $PWD:/usr/src/codechan -w /usr/src/codechan -p 5000:5000 vedsted/codechan:latest-base python run.py'
        sh 'curl localhost:5000'
        stash name: "repo", includes: "**", useDefaultExcludes: false
    }
}

node('privileged'){
	stage('Publish image'){
		unstash 'repo'
        sh '$(pwd)/deployment/deploy_image.sh'
        deleteDir()
    } 
}


