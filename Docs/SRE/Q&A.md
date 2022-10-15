1.	What are your considerations for building a deployment process?
- Collaboration between stakeholders, make consensus of the process

- Deployment Strategies, should have deployment strategies to define how to deliver our application (e.g. blue-green deployment, canray deployment, and rollback strategy)

- Minimize the amount of change, balance the frequency and size of the releases

- Set up and test DevOps pipeline as early in the project as possible

- Automation the most of the deployment process, make the most deployment process as code as possible, and well document

- Dedicate CICD environment (e.g. a dedicate container/vm/cloud build), to make sure the deployment process is rubost enough

- Monitoring, the KPI and logs for the application

- Have post mortem session, get review and feedbak for the process

</br>

2.	What do you look for in your ideal team in terms of practices, processes, and behaviours?
- Clear target / goal for what we are doing for
- Well understand documents for the process
- Open and flexible environment for the feedback, sharing and improvement

</br>

3.	How do you know something has gone wrong in production?
- In my current job:
  - We will config GCP skackdrive monitoring alerting policies base on SLI of application and related environment, and receive alert from that policy when the SLI is hit
  - And also config transaction tracing in Appdynamic, to make us understand the details of the traffic flow in the application, and address the issue in application
  
</br>

4.	In your opinion what is ‘good code’?
- Good code should make people easy to understand: 
  - why we need this code
  - how does it work
  - code reference from
  - well to debug and reproduce
  - with unit test

</br>

5.	What are your thoughts and experiences around infrastructure as code?
- Infrastructure as code make infra more clear and easy to understand, with IaC, we can speed up the infra provision process, what we code is what we got.
- In my current job, 
  - Regarding to the company security policy, every project's hosting OS image must keep update every 60~80 days, so I used packer + powershell / shell / ansible to build the OS image, push it to the image family (aka Compute Gallery in Azure), then replace the hosting OS image with cloud vendor cli, these process are done by Jenkins pipeline.
  - Develop terraform module to provision cloud infrastructure fit for project and compliance requirement
- For more example from my personal project, have a check with my github repo: https://github.com/fsdrw08

</br>

6.	What is your availability?
- I am available to work in flexable, regular working hour range in CST (UCT+8): 8AM~6PM , it depends on the job requirement, I can make 1~1.5 hour earlier to work to sync with NZ's working hour

7.	What are your salary expectations?
- ~ RMB 24k * 13 annually, there is room for negotiation