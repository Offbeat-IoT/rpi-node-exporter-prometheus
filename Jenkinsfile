pipeline {
    agent 'built-in'
    stages {
        stage('Deploy') {
            steps {
                script {
                    def nodes = []
                    if (env.BRANCH_NAME == 'main' ||env.BRANCH_NAME == 'fixing'  ) {
                                checkout scm
                                sh 'docker compose up -d'

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
