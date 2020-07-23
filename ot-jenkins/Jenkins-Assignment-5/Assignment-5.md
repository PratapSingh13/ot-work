# build-and-release
## Jenkins Assignment-5 ##

**Create a Jenkins job that should send an EmailAlert on every execution**

![alt text](image/task_1.1.png "Title Text")

For this we can create Editable Email Notification on Post Build Action and provide the required details which is given on like Project From.......
We need to attach build log as **Attach Build Log**
![alt text](image/task_1.2.png "Title Text")

## Output ##

![alt text](image/task_1.3.png "Title Text")


**Modify above Jenkins job to send notification only in case of state change i.e when it fails for first time, or succeed after failure**

For sending notification when it fails we need to add trigger as **Failure-1st** in Advanced Setting  
![alt text](image/task_2.1.png "Title Text")

For sending notification when **succeed after failure** we need to add trigger as **Unstable (Test Failures)/failure->Success** in Advanced Setting

![alt text](image/task_2.2.png "Title Text")

## Output ##

![alt text](image/task_2_output.png "Title Text")

**Modify above Jenkins job to send console output as an attachment**

For this we need to **Attach Build Log** in Attach build log option.
![alt text](image/task_3.png "Title Text")

![alt text](image/task_3_output.png "Title Text")

**Modify above Jenkins job to add console output as mail body instead of attachment**

For this we need to make Attach build log as **Do not Attach Build Log** 

![alt text](image/task_4.png "Title Text")

**Create a Jenkins job (ManageUser) that will take a user name as input and create it in local system**
For this we need to make our job as **This Project is Parametrized** in **General** section on that we need to choose **String Parameter** on that fillthe credential Such as Name, Description.....

![alt text](image/task_5.1.png "Title Text")

Next we need to choose **Execute Shell** in **Build** section and use command to create user i.e. **$ sudo useradd -m $username**
![alt text](image/task_5.2.png "Title Text")

![alt text](image/task_5.3.png "Title Text")

## Output ##
![alt text](image/task_5_output.png "Title Text")

**Modify ManageUser jenkins job to take remote system IP as input to create the user**
For this we need to install plugin i.e. **Publish over SSH** after insstalling the plugin we have to configure pluggin in **Manage Jenkins--->Configure System** in this we need to put Jenkins User private SSH key and put the path of that private key in required block.
In Advance we need to set SSH Server on that put the Hostname IP and Username 

![alt text](image/task_6.1.png "Title Text")

In General section build this Project is Parametrized (String Parameter) 

![alt text](image/task_6.2.png "Title Text")

In Build Environment **Send files or execute commands over SSH before the build starts** in which we put the useradd command in **Exec Command**

![alt text](image/task_6.3.png "Title Text")

Now enter the User_Name which you want if you don't do so then it will automatically create user named **newuser**

![alt text](image/task_6.4.png "Title Text")

## Console Output ##
![alt text](image/task_6_output.png "Title Text")

## Output ##

![alt text](image/task_6_output_1.png "Title Text")

**Modify ManageUser jenkins job to take additional parameters for remote system to be managed such as**
* Username
* Home
* Shell

For this task we need create Parametrized Job named **String Parameter** one for username and one for shell  
![alt text](image/task_7.1.png "Title Text")

In the Build Environment check **Send files or execute commands over SSH before the build starts** and put **Exec Command** to run script aka we can
say command.

![alt text](image/task_7.2.png "Title Text")

![alt text](image/task_7_output.png "Title Text")

![alt text](image/task_7_output_1.png "Title Text")
