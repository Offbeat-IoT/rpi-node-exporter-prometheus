pipeline {
    agent none
    stages {
        stage('Deploy') {
            steps {
                script {
                    def targetNodes = []
                    if (env.BRANCH_NAME == 'main') {
                        targetNodes = nodesByLabel('')
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
