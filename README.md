@Library('my-shared-library') _

pipeline {
    agent any

    tools {
        maven 'maven3'
        jdk 'OracleJDK8'
    }

    environment {
        SNAP_REPO = 'eawangya-snapshot'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin123'
        RELEASE_REPO = 'eawangya-release'
        CENTRAL_REPO = 'eawangya-maven-central'
        NEXUSIP = '192.168.56.18'
        NEXUSPORT = '8081'
        NEXUS_GRP_REPO = 'eawangya-group'
        NEXUS_LOGIN = 'nexus-creds'
        SONARSERVER = 'sonarserver'
        SONARSCANNER = 'sonarscanner'
        AZURE_CREDENTIALS = credentials('AzureServicePrincipal')
        RESOURCE_GROUP = 'kube-rg'
        LOCATION = 'Central US'
        ISTIO_VERSION = '1.20.0'
        ISTIO_INSTALL_DIR = "/var/lib/jenkins/workspace/profile-project/istio-${ISTIO_VERSION}"
        ISTIO_PATH = "/var/lib/jenkins/workspace/profile-project/istio-1.20.0/bin"
    }


    stages {

        stage("git Checkout"){
            steps {
                script {
                     gitCheckout(
                        branch: "main",
                        url: "https://gitlab.com/ernest.awangya/profile_app.git"
                    )
                }
            }
        }
        stage("Maven: Unit Test"){
            steps {
                script {
            echo "Contents of 'target' directory before Maven build:"
            sh "ls -R target"
            mvnTest()
            echo "Contents of 'target' directory after Maven build:"
            sh "ls -R target"
                }
            }
        }
        stage("Maven: Intergration Test"){
            steps {
                script {
                    mvnIntegrationTest()
                }
            }
        }
        stage("CheckStyle Analysis"){
            steps {
                script {
                    checkstyleanalysis()
                }
            }
        }        
        stage("SonarQube Analysis") {
            steps {
                script {
                    def SonarQubecredentialsId = 'sonar-token'
                    statiCodeAnalysis(SonarQubecredentialsId)
                }
            }
        }

        stage("Quality Gate Status Check") {
            steps {
                script {
                    def SonarQubecredentialsId = 'sonar-token'
                    qualityGateStatus(SonarQubecredentialsId)
                }
            }
        }
        stage("Maven: Build"){
            steps {
                script {
                    mvnBuild()
                }
            }
        }        

    }

}