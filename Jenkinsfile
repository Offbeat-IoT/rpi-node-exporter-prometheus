pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def targetNodes = []
                    if (env.BRANCH_NAME == 'main') {
                        // Gather nodes from common deployment labels
                        targetNodes += nodesByLabel('build')
                        targetNodes += nodesByLabel('production')
                        targetNodes += nodesByLabel('observability')
                    } else {
                        // Only use build nodes for feature branches
                        targetNodes += nodesByLabel('build')
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
