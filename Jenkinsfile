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
        deleteDir()
    }

}

node('deployment_test'){
    stage('Deploy -test'){
        unstash 'repo'
        sh 'docker pull vedsted/codechan:latest-base'
        sh 'docker run -d --rm --name codechan_Test_Script -v $PWD:/usr/src/codechan -w /usr/src/codechan -p 5000:5000 vedsted/codechan:latest-base python run.py'
        sh 'sleep 8s'
        sh 'curl 127.0.0.1:5000'
        sh 'docker stop codechan_Test_Script'
        stash name: "repo_2", includes: "**", useDefaultExcludes: false
        deleteDir()
    }
}

node('privileged'){
	stage('Publish image'){
		unstash 'repo_2'
        sh 'cd deployment && . deploy_image.sh'
        deleteDir()
    } 
}


