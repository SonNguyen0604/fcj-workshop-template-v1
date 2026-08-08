---
title: "Blog 2 - ALB and Auto Scaling Group: a self-healing application tier"
date: 2026-08-08
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---

# ALB + Auto Scaling Group: how I built a self-healing application tier on AWS

An application running on a single EC2 instance has an obvious weakness: if that server fails, users lose the application endpoint. In my High Availability project, I combined **Application Load Balancer (ALB)** and **Auto Scaling Group (ASG)** to reduce dependency on one server.

## ALB's role

The ALB is the public entry point. Users do not call EC2 directly; requests go through the ALB and are routed only to healthy targets.

In my lab:

* The ALB is deployed in public subnets.
* EC2 instances are in private subnets.
* The Target Group uses HTTP port 80.
* The health check path is `/`.

A key point: the ALB **does not repair a failed server**. It only stops routing traffic to an unhealthy target.

## Auto Scaling Group's role

The ASG manages EC2 capacity with:

* `min_size = 2`
* `desired_capacity = 2`
* `max_size = 3`
* `health_check_type = "ELB"`

When one instance is terminated, the actual capacity becomes lower than Desired Capacity. The ASG then launches a new instance from the Launch Template to restore the required capacity.

## How ALB and ASG complement each other

* **ALB** handles routing and target health checking.
* **ASG** maintains capacity and replaces instances.
* **Launch Template** ensures replacement instances use consistent AMI, Security Group, and user_data settings.

Together, they provide a more **self-healing** application tier than a single-EC2 design.

## Common confusion: self-healing is not the same as dynamic scaling

In the current demo, my CloudWatch Alarm is used only for CPU monitoring. I **did not configure a Target Tracking/Dynamic Scaling policy**. Therefore, the project demonstrates Desired Capacity restoration after instance failure; it does not claim CPU-based scale-out.

A future version could use Target Tracking with metrics such as `ASGAverageCPUUtilization` or `ALBRequestCountPerTarget`, depending on the workload.

## Lesson learned

High Availability does not come from one AWS service. ALB, Target Group, Launch Template, and ASG must be configured consistently. It is also important to distinguish **traffic routing**, **instance replacement**, and **dynamic scaling** because they are different mechanisms.

---

**Article created:** 08/08/2026

---

## Sharing information

* **Content created:** 08/08/2026
* **Published:** 08/08/2026
* **Published in:** AWS Study Group VN
* **Status:** Published and approved by the group administrators.

## Evidence

{{< assetimg src="images/3-BlogsPosted/blog2-aws-study-group.png" alt="ALB and Auto Scaling Group post shared in AWS Study Group VN" >}}
