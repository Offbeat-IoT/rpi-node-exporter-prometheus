pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def targetNodes = []
                    if (env.BRANCH_NAME == 'main') {
                        ['build', 'production', 'observability'].each { label ->
                            targetNodes += nodesByLabel(label)
                        }
                        targetNodes = targetNodes.unique()
                    } else {
                        targetNodes = nodesByLabel('build')
                    }

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
