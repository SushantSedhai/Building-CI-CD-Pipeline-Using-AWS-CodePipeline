# Jenkins setup

1. Create a role and attach policy `AWSCodePipelineCustomActionAccess` for EC2 access: JenkinsAccess

```json
{
  "Statement": [
        {
            "Action": [
                "codepipeline:AcknowledgeJob",
                "codepipeline:GetJobDetails",
                "codepipeline:PollForJobs",
                "codepipeline:PutJobFailureResult",
                "codepipeline:PutJobSuccessResult"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
  ],
  "Version": "2012-10-17"
}
```

2. Create an EC2 instance where you will install Jenkins
3. Edit Security group to add `Custom TCP Role` with port `8080`
4. Install Jenkins on EC2 instance

```shell
   sudo yum update –y
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
   sudo yum upgrade
   sudo amazon-linux-extras install java-openjdk11 -y
   sudo yum install jenkins -y
   sudo systemctl enable jenkins
   sudo systemctl start jenkins
```

5. Launch Jenkins

   - Browse to EC2 instance `http://<your_ec_instance_dns_address>:8080/`
   - Get password using  `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

7. On the `Manage Jenkins` page, choose `Manage Plugins`.

8. Choose the `Available` tab, and in the Filter search box, enter `AWS CodePipeline`. Choose CodePipeline Plugin for Jenkins from the list and choose Download now and install after restart.

9. On the `Installing Plugins/Upgrades` page, select `Restart Jenkins when installation is complete and no jobs are running`.

10. Go to `Dashboard`. Choose `New Item`. In Item Name, enter a name for the Jenkins project (MyDemoProject). Choose `Freestyle project`, and then choose `OK`.

11. On the configuration page for the project, select the `Execute concurrent builds if necessary` check box. In Source Code Management, choose AWS CodePipeline

11.Choose `Advanced`, and in Provider, enter a name (MyJenkinsProviderName) for the provider of the action as it will appear in CodePipeline

12. In `Build Triggers`, clear any check boxes, and then select `Poll SCM`

`Schedule: * * * * *`

13. Choose `Add post-build action`, and then choose `AWS CodePipeline Publisher`. Choose `Add`, and in `Build Output Locations`, leave the location blank.

14. Choose `Save` to save your Jenkins project
