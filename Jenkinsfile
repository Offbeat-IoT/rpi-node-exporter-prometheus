pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def nodes = []
                    if (env.BRANCH_NAME == 'main') {
                        // Gather nodes from common deployment labels
                        nodes += nodesByLabel('built-in')
                        nodes += nodesByLabel('build')
                        nodes += nodesByLabel('production')
                        nodes += nodesByLabel('observability')
                    } else {
                        // Only use build nodes for feature branches
                        nodes += nodesByLabel('build')
                    }
                    nodes = nodes.unique()

                    def tasks = nodes.collectEntries { n ->
                        [(n): {
                            node(n) {
                                checkout scm
                                sh 'docker compose up -d'
                            }
                        }]
                    }
                    parallel tasks
                }
            }
        }
    }
}
