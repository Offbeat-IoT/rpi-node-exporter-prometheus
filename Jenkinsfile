pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def nodes = []
                    if (env.BRANCH_NAME == 'main' ||env.BRANCH_NAME == 'fixing'  ) {
                        // Gather nodes from common deployment labels
                        nodes += nodesByLabel('built-in')
                        nodes += nodesByLabel('production')
                        nodes += nodesByLabel('observability')
                        nodes += nodesByLabel('build')
                    } else {
                        // Only use build nodes for feature branches
                        nodes += nodesByLabel('build')
                    }
                    nodes = nodes.unique()

                    def tasks = nodes.collectEntries { n ->
                    echo "###############"
                    echo "$n"
                    def nodeName = n.id
                        [(nodeName): {
                            node(nodeName) {
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
