pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def targetNodes
                    if (env.BRANCH_NAME == 'main') {
                        // Collect every node configured in Jenkins
                        targetNodes = jenkins.model.Jenkins.instance.nodes.collect { it.nodeName }
                        // Include the controller in case it's not in the list
                        targetNodes += 'master'
                    } else {
                        // Only use build nodes for feature branches
                        targetNodes = nodesByLabel('build')
                    }
                    targetNodes = targetNodes.unique()

                    def tasks = [:]
                    for (n in targetNodes) {
                        tasks[n] = {
                            node(n) {
                                checkout scm
                                sh 'docker compose up -d'
                            }
                        }
                    }
                    parallel tasks
                }
            }
        }
    }
}
