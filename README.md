# python-jenkins-aws

Testing integration with Jenkins running on EC2.  Modified several tutorials to set up an ECS cluster for jenkins and docker in an autoscaling group.  Jenkins receives a webhook on pushing to master branch and it triggers a pipeline build.  

Pipeline runs verification in parallel:  `py_compile` to check syntax, `pylint` and `pytest-pep8` for linting, and `pytest` to run unit tests.  After passing verification, the project is compiled to a binary using `pyinstaller` and the artifacts are saved in Jenkins with HTML reports where applicable.  

## Resources
Some of the resources I found helpful:  
- [CI/CD Pipeline](https://docs.aws.amazon.com/AWSGettingStartedContinuousDeliveryPipeline/latest/GettingStarted/CICD_Jenkins_Pipeline.html)
- [AWS Jenkins build server](https://d1.awsstatic.com/Projects/P5505030/aws-project_Jenkins-build-server.pdf)
- [Build pipeline with jenkins and ECS](https://aws.amazon.com/blogs/devops/set-up-a-build-pipeline-with-jenkins-and-amazon-ecs/)
- [Running docker-aws from the ground up](https://www.ybrikman.com/writing/2015/11/11/running-docker-aws-ground-up/)

## Tutorial Info 
This repository is for the
[Build a Python app with PyInstaller](https://jenkins.io/doc/tutorials/build-a-python-app-with-pyinstaller/)
tutorial in the [Jenkins User Documentation](https://jenkins.io/doc/).  This tutorial has been modified to use a remote instance of Jenkins running on AWS. 

The repository contains a simple Python application which is a command line tool "add2vals" that outputs the addition of two values. If at least one of the
values is a string, "add2vals" treats both values as a string and instead
concatenates the values. The "add2" function in the "calc" library (which
"add2vals" imports) is accompanied by a set of unit tests. These are tested with pytest to check that this function works as expected and the results are saved
to a JUnit XML report.

The delivery of the "add2vals" tool through PyInstaller converts this tool into
a standalone executable file for Linux, which you can download through Jenkins
and execute at the command line on Linux machines without Python.

The `jenkins` directory contains an example of the `Jenkinsfile` (i.e. Pipeline)
you'll be creating yourself during the tutorial.

