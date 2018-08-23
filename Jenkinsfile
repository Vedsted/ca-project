node {
  //cleanWs()

    stage('Preparation') { // for display purposes
        // Get some code from a GitHub repository

    checkout([$class: 'GitSCM', branches: [[name: '**/ready/**']], 
    doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout'], 
    pretestedIntegration(gitIntegrationStrategy: accumulated(), integrationBranch: 'master', 
    repoName: 'origin')], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'thevinge', 
    url: 'git@github.com:Vedsted/ca-project.git']]])
    
    stash name: "repo", includes: "**", useDefaultExcludes: false
    }
    
    stage('Test') {
        // Run the maven build
        if (isUnix()) {
           sh 'docker run -i -u "$(id -u):$(id -g)" -v $PWD:/usr/src/codechan -w /usr/src/codechan --rm python tests.py'
            //sh "mvn -Dmaven.test.failure.ignore clean package"
//            stash name: "build-result", includes: "target/**"

        }
    }
    stage('Push'){
        pretestedIntegrationPublisher()

        deleteDir()
    }
  }
}