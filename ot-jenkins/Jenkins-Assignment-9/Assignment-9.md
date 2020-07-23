# Jenkins Assignment-9 #

**Assignment-9.1**

**Create a scripted pipeline that will containe different stages of a CI/CD pipeline. Include all CI and CD jobs.**
For this we can **Build Pipeline View** as named **CI** and after this we need to configure **Pipeline flow** our CI build on this I make first
 **Compile** 
![alt text](image/task1.1.png "Title Text")


![alt text](image/task1.2.png "Title Text")


After that we need to create Job for which I named **Compile** and on that we need to make scm over the Git from their Jenkins will get the repository

![alt text](image/task1.3.png "Title Text")

On Build section make **Invoke top level Maven Projects** and put **compile** on Goal.

![alt text](image/task1.4.png "Title Text")

After this we have to create a new Job for test on this we can Build triggers on this **Build after other projects are built** on this I take after 
compile.



![alt text](image/task1.5.png "Title Text")


Then we need to build our job as test in **Build** section


![alt text](image/task1.6.png "Title Text")


**Output**

![alt text](image/task1_output.png "Title Text")
