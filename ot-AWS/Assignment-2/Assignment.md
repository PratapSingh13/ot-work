# AWS #
## Assgnment-2 ##
## Task-1 ##

#### Create a vpc not by wizard this time but manually, having 2 public subnets and 2 private subnets and 2 protected subnets.setup should be highly available
- Create 1 IGW and 2 NGW in each availability zone and make the appropriate routes in route tables
- Main route will remain intact, instead make 4 route tables
- Public_route_table
- Private_route_table_1
- Private_route_table_2
- Protected_route_table

First I need to create a VPC which I named **VPC-Mumbai** with CIDR of **10.0.0.0/16**

![alt text](images/1.png "Title Text")

So in first step I created VPC

![alt text](images/2.png "Title Text")

Then as per task requirement we need to create **2 public subnets and 2 private subnets and 2 protected subnets** which I created with different CIDR

![alt text](images/3.png "Title Text")

1 IGW and 1 NGW also required which also created after subnets creation

Now time to maintain Route-table
Created Route-Table for Public


![alt text](images/4.png "Title Text")

Then firstly mention IGW in Public Route

![alt text](images/5.png "Title Text")

After this I associated Public Subnets into Public Route-Table

![alt text](images/6.png "Title Text")

For Private Route-table need to add NGW

![alt text](images/7.png "Title Text")

And after this for subnet association did same as public subnet association

![alt text](images/8.png "Title Text")

For Protected Subnet need not to add anything

![alt text](images/9.png "Title Text")

Protected Subnet association done as same as Public and Private Subnet association done

![alt text](images/10.png "Title Text")

Now it is our final route-table

![alt text](images/11.png "Title Text")

**--------------------------------------------------------------------------------------------------------------------------------------------------**

## Task-2 ##

Make LAMP setup with 2 instances in each private subnets.
Server-1 should serve a webpage that would say "Hi! i am server 1"
Server-2 should serve a webpage that would say "Hi! i am server 2"

SSH to our EC2 instance 

![alt text](images/12.png "Title Text")

Changed Nginx index.html page

![alt text](images/13.png "Title Text")

This will done on both Private Instances

**--------------------------------------------------------------------------------------------------------------------------------------------------**

## Task-3 ##
Launch a public load balancer that would forward the requests to these 2 LAMP instances
create the same setup using aws-cli except vpc
**NOTE** Machines in the protected subnets shouldn't be going to internet and vice versa (verify this by launching an instance in this subnet)
Make Documentation and push to the repo
Make sure you copy the actual logs in the documentation.

For this here I'm creating **Network Load Balancer** 

![alt text](images/14.png "Title Text")

Next Need to configure our Load Balancer

![alt text](images/15.png "Title Text")

After configuring we need to **Register Targets** here I checked for my both Instances

![alt text](images/16.png "Title Text")

After this Load balancer will be created

![alt text](images/17.png "Title Text")

![alt text](images/18.png "Title Text")

![alt text](images/19.png "Title Text")

**--------------------------------------------------------------------------------------------------------------------------------------------------**
