---
title: "Worklog Week 2"
date: 2026-06-24
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---

### Week 2 Objectives:

* Master foundational knowledge of AWS Networking, instance provisioning, and secure connectivity solutions.
* Build and standardize technical documentation for the team, preparing the baseline system monitoring framework via CloudWatch.

### Tasks to Deploy This Week:

<table>
  <thead>
    <tr>
      <th>Day</th>
      <th>Task Description</th>
      <th>Start Date</th>
      <th>End Date</th>
      <th>Reference Resource</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Mon</td>
      <td>
        <ul>
          <li>
            Research Amazon VPC & Core Networking Foundations:
            <ul>
              <li>Create VPC, Subnets, Internet Gateways, Route Tables, and Security Groups.</li>
              <li>Enable VPC Flow Logs to capture IP traffic data.</li>
              <li><i>Personal Task: Aggregated documentation and recorded the team's network parameters.</i></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>29/06/2026</td>
      <td>29/06/2026</td>
      <td><a href="https://000003.awsstudygroup.com/3-prerequisite/">AWS Study Group Lab 3</a></td>
    </tr>
    <tr>
      <td>Tue</td>
      <td>
        <ul>
          <li>
            Deploy Amazon EC2 Instances & Core Monitoring Infrastructure:
            <ul>
              <li>Provision EC2 Servers, configure NAT Gateways, and set up EC2 Instance Connect Endpoints.</li>
              <li>Verify secure remote connections to instances using VS Code.</li>
              <li><b>Personal Task: Researched and set up baseline CloudWatch Monitoring & Alerting for newly created instances.</b></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>30/06/2026</td>
      <td>30/06/2026</td>
      <td><a href="https://000003.awsstudygroup.com/4-createec2server/">AWS Study Group Lab 4</a></td>
    </tr>
    <tr>
      <td>Wed</td>
      <td>
        <ul>
          <li>
            Research Site-to-Site VPN Connection Establishment on AWS:
            <ul>
              <li>Simulate a hybrid cloud environment by setting up VPN environments and configuring VPN Connections.</li>
              <li>Configure secure VPN tunnels combining Strongswan with Transit Gateway.</li>
            </ul>
          </li>
        </ul>
      </td>
      <td>01/07/2026</td>
      <td>01/07/2026</td>
      <td><a href="https://000003.awsstudygroup.com/5-vpnsitetosite/">AWS Study Group Lab 5</a></td>
    </tr>
    <tr>
      <td>Thu</td>
      <td>
        <ul>
          <li>
            Research Microsoft Active Directory Deployment on AWS:
            <ul>
              <li>Prepare automated resources (Key pair, CloudFormation template, and Security Groups).</li>
              <li>Deploy Microsoft AD, set up Private DNS, and secure administrative access via RDGW.</li>
              <li><i>Personal Task: Edited the troubleshooting guide for domain connection issues for the team.</i></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>02/07/2026</td>
      <td>02/07/2026</td>
      <td><a href="https://000010.awsstudygroup.com/">AWS Directory Service Docs</a></td>
    </tr>
    <tr>
      <td>Fri</td>
      <td>
        <ul>
          <li>
            Research and Secure Inter-VPC Peering Connections:
            <ul>
              <li>Update Network ACLs, configure VPC Peering, and enable Cross-Peer DNS resolution.</li>
              <li><b>Personal Task: Consolidated all hands-on data, finalized Week 2 Worklog, and drafted the outline for Blog Post 1.</b></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>03/07/2026</td>
      <td>03/07/2026</td>
      <td><a href="https://000002.awsstudygroup.com/">AWS VPC Peering Lab</a></td>
    </tr>
  </tbody>
</table>

### WEEK 2 ACCOMPLISHMENTS: ADVANCED NETWORKING & INFRASTRUCTURE PROVISIONING

1. **AWS Networking & VPC Architecture**
   - **VPC Foundation:** Collaborated with the team to design a custom Virtual Private Cloud (VPC) tailored for high-availability infrastructure, separating public and private subnets clearly.
   - **Traffic Control:** Standardized Route Tables and Security Groups while enabling VPC Flow Logs to collect precise traffic insights for future troubleshooting.

2. **EC2 Compute & Observability (CloudWatch)**
   - **Instance Deployment:** Successfully launched experimental Amazon EC2 instances, establishing secure routing via NAT Gateways and verifying remote SSH access via VS Code.
   - **Personal Monitoring Setup:** Proactively configured CloudWatch baseline metrics for EC2 servers, preparing the groundwork for automated threshold alerting in later phases.

3. **Hybrid Connectivity & Directory Services**
   - **Secure VPN Tunnels:** Mastered the process of establishing an encrypted communication channel between on-premises environments and AWS using Strongswan and Transit Gateway.
   - **Microsoft AD Governance:** Explored Microsoft Active Directory deployment automation via CloudFormation templates and secured remote administration through Remote Desktop Gateway (RDGW).

4. **Team Documentation & Technical Writing Optimization**
   - Excelled in the Technical Writer role by compiling and organizing configuration steps for VPC Peering and cross-peer DNS resolution.
   - Drafted a comprehensive content outline for technical Blog Post 1, preparing for submission to the AWS Facebook community.
