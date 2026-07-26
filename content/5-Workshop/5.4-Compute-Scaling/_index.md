---
title: "5.4 Compute & Auto Scaling"
date: 2026-07-27T10:10:00+07:00
weight: 4
---

### 1. Launch Template Configuration

To ensure all EC2 instances are provisioned with an identical, stateless configuration, I utilized a **Launch Template**. This template specifies:
*   **AMI:** Amazon Linux 2023.
*   **Instance Type:** t2.micro or t3.micro (suitable for lab environments).
*   **User Data:** Contains a bootstrap script to install Docker, pull the Python (FastAPI) application image, and run the container upon boot.

### 2. Auto Scaling Group (ASG) Setup

The core of High Availability at the application tier relies on the **Auto Scaling Group**. The ASG is configured with the following parameters:
*   **Distribution:** Spanning across 2 Private Subnets in 2 different AZs.
*   **Capacity:** Min = 2, Desired = 2, Max = 4.
*   **Self-healing Mechanism:** The ASG continuously monitors the health of EC2 instances. If an instance becomes unhealthy, the ASG automatically terminates it and launches a replacement instance using the defined Launch Template.

<img width="1893" height="868" alt="image" src="https://github.com/user-attachments/assets/74407911-1949-41cd-a6df-1c7bc21f00dc" />
`![Auto Scaling Group](/images/asg-setup.png)`
