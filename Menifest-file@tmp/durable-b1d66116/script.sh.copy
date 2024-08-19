
                            ls  
                            git config --global user.email "chaudharichaitanya998@gmail.com"
                            git config --global user.name "chaitanya717"
                            BUILD_NUMBER=${BUILD_NUMBER}
                            echo $BUILD_NUMBER
                            git remote -v
                            sed -i "s/tetrisv1:${BUILD_NUMBER}/tetrisv1:${BUILD_NUMBER}/" deployment-service.yaml
                            git add ../Menifest-file@tmp/
                            git add deployment-service.yaml
                            git commit -m "Update deployment Image to version ${BUILD_NUMBER}"
                            git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                        