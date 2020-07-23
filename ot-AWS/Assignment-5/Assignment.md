# AWS #
## Assgnment-5 ##
## Task-1 ##

**Create a ASG for CPU utilization greater than 40% and check the status.**

Go on **Services** and **EC2** option

![alt text](images/1.png "Title Text")

At bottom their is option for **Auto Scaling** we have two sub-options 

Here we have two options i.e. **Launch Configurations** & **Auto Scaling Groups**
If we talk about **Launch Configurations** In Launch Configurations we decide which instance we need to create during Auto Scaling So to do Auto Scaling first I need to go on Launch Configurations for instance creation

![alt text](images/2.png "Title Text")

Create Launch Configuration and **Choose Instance type** in which I choose **Microsoft Windows Server 2012 R2 Base**

![alt text](images/3.png "Title Text")

Now **Configure details** of Launch Configuration I named it *Launch-Configuration*

![alt text](images/4.png "Title Text")

Here is the option for spot instances if I clicked on that it shows price on all Availability Zone and in **Maximum Price** option we can set our price options also but here I'm not going to use on spot instance

**Note-** We can take only one either spot instance or on-demand instance we cann't choose both

I'm not using **IAM role** & **Monitoring** here

Adding storage for 30GB which is default for Windows Server

![alt text](images/5.png "Title Text")

**Note-** Here we can not encrypt our Root volume, while if we add another volume that can be able to encrypt.

![alt text](images/6.png "Title Text")

This is **Security Group Configuration** for Auto Scaling

![alt text](images/7.png "Title Text")

Here I created **Launch Configuration** this is the status of Launch Configuration creation in which it is giving directly option for **Create a Auto SCaling Group using this Launch Configuration** which I'm going to use this.

![alt text](images/8.png "Title Text")

Here I give **AutoScaling** as name and take **2** as group size which means it starts with 2 instances initially.

![alt text](images/9.png "Title Text")

Here I'm using all the availability zones for server creation benefit from this is what if our 1 server got crashed then rest all servers are running for management

![alt text](images/10.png "Title Text")

In **Configuring Scaling Policies** we got two options in which one of them is **Keep this group at its initial size** which means a kind of manual scaling, So here I'm using another one.

![alt text](images/11.png "Title Text")

If we go forward on Keep this group at its initial size then here ***Minimum group size*** & ***Maximum Group Size*** are same which is 2

![alt text](images/12.png "Title Text")

So, I'm rooting towards ***Use scaling policies to adjust the capacity of this group***

**This policy is known as Target Tracking Policy**

In this I take Scale between minimum 2 and maximum 5 instances.
Name as ***ASG***
Metric Size ***CPU Utilization*** (Because of demand in question)
Target Value **40** which means after 40% of CPU utilization new instance will be created

![alt text](images/13.png "Title Text")

Keep Un-Checked for ***Disable Scale in*** option because if I checked it then we can only increase instances but not decrease

![alt text](images/13.png "Title Text")

In Simple Scaling Policy 

I need to give instruction to AWS in the form of ***Set Alarm***
Here I set alarm in which assign 40% for CPU Utilization and increase instance if traffic goes high for consecutive 1 minute

![alt text](images/14.png "Title Text")

And in Increase Group Size add 1 instance

![alt text](images/15.png "Title Text")

Same thing for Decrease group size but here I changed periods of time by 5 minutes

![alt text](images/16.png "Title Text")

Decrease/Remove 1 instance for the same

![alt text](images/17.png "Title Text")

Auto Scaling is created successfully

![alt text](images/19.png "Title Text")

![alt text](images/20.png "Title Text")

As we defined in our Auto Scaling that we set minimum group size is 2 here 2 instances are getting start

![alt text](images/21.png "Title Text")

Here I launched my both instances

![alt text](images/22.png "Title Text")

For testing our ASG I created a file of ***.bat*** extension on both instances

![alt text](images/23.png "Title Text")

Increase the traffic by open a.bat file by multiple times on both instances

![alt text](images/24.png "Title Text")

### Result ###

![alt text](images/25.png "Title Text")

**--------------------------------------------------------------------------------------------------------------------------------------------------**

## Task-2 ##

**Create an ELB balancing the load between 3 servers. It should say:**
***Hello, I am server-1***
***Hello, I am server-2***

For this I have created two EC2 instances (Windows Instances)

![alt text](images/26.png "Title Text")

Connect on each instances and open ***Server Manager*** on ***Start*** section

![alt text](images/27.png "Title Text")

Go into ***Add roles and features***

![alt text](images/28.png "Title Text")

Click next until ***Server Roles*** section on this select ***Web Server IIS***

![alt text](images/29.png "Title Text")

![alt text](images/30.png "Title Text")

Install it.

![alt text](images/31.png "Title Text")

Now Goto the **Local Disk:c---->inetpub---->wwwroot** and created ***index.html***

![alt text](images/32.png "Title Text")

Now time to create ***Load Balancer***
For this select **Load Balancers** option from ***LOAD BALANCING***

![alt text](images/33.png "Title Text")

Create Laod Balancer

![alt text](images/34.png "Title Text")

Configure ***Health Check***

![alt text](images/35.png "Title Text")

Add EC2 instances to the Target

![alt text](images/36.png "Title Text")

![alt text](images/37.png "Title Text")

Load Balancer created Successfully

![alt text](images/38.png "Title Text")

Now we need to create ***Target Group***

![alt text](images/39.png "Title Text")

Create Target Group configuration

![alt text](images/40.png "Title Text")

Register Targets which is EC2 instances into Target Group and all done to wait for some time to check Health status

![alt text](images/41.png "Title Text")

Now our Targets are Healthy

![alt text](images/42.png "Title Text")

To test the result copy **DNS Name** from **Description**

![alt text](images/43.png "Title Text")

### Results ###

![alt text](images/44.png "Title Text")

![alt text](images/45.png "Title Text")

**--------------------------------------------------------------------------------------------------------------------------------------------------**

## Task-3 ##
**Create an ALB by creating 2 target group with 2 server each. First target group server says "Hello World" and second target group server says "Bye world".**

For this I have created four EC2 instances (Windows Instances)

![alt text](images/46.png "Title Text")

Connect on each instances and open ***Server Manager*** on ***Start*** section

![alt text](images/27.png "Title Text")

Go into ***Add roles and features***

![alt text](images/28.png "Title Text")

Click next until ***Server Roles*** section on this select ***Web Server IIS***

![alt text](images/29.png "Title Text")

![alt text](images/30.png "Title Text")

Install it.

![alt text](images/31.png "Title Text")

Now Goto the **Local Disk:c---->inetpub---->wwwroot** and created ***index.html***

![alt text](images/32.png "Title Text")

Now time to create ***Load Balancer***
For this select **Load Balancers** option from ***LOAD BALANCING***

![alt text](images/33.png "Title Text")

Create Laod Balancer

![alt text](images/34.png "Title Text")
