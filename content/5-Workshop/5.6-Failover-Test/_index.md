---
title: "5.6 Failover Testing"
date: 2026-07-27T10:30:00+07:00
weight: 6
---

### Experimental Scenario: Simulating Server Failure

To validate that the architecture meets High Availability standards, I conducted a proactive failure injection test (basic Chaos Engineering).

**Execution Steps:**
1.  Accessed the EC2 Console, randomly selected 1 running application instance, and executed the **Terminate** command (simulating a hardware failure or OS crash).
2.  Instantly, the **Application Load Balancer** detected the unhealthy target via its Health Check mechanism and rerouted all user requests to the surviving instance in the second AZ. The system continued to serve traffic without complete disruption.
3.  Within 1-2 minutes, the **Auto Scaling Group** recognized a mismatch between the Desired Capacity (2) and the actual healthy count (1). It automatically triggered the Launch Template to provision a brand-new EC2 instance to replace the terminated one.

<img width="1888" height="922" alt="image" src="https://github.com/user-attachments/assets/6f2398dc-1061-42c0-a056-7b8e9e3d95a4" />
<img width="1889" height="920" alt="image" src="https://github.com/user-attachments/assets/f72fa875-fa9c-48d0-b7c6-6afc91470016" />
`![ASG Failover Log](/images/asg-failover.png)`

**Conclusion:** The system successfully demonstrated its self-healing capabilities exactly as designed in the architecture.
