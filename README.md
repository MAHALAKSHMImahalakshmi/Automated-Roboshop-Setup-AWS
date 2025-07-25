# 🤖 Roboshop Automation Journey – IBM Project 🚀

Welcome to my Roboshop Automation repository!  
This project is my hands-on journey in automating the deployment of a complex microservices-based e-commerce application for an IBM project, using **Bash scripting**, **systemd**, and **AWS**.  
My goal: **Zero manual steps, 100% automation, and bulletproof reliability!** 🛡️

---

## 🌟 Project Highlights

- **11 EC2 Instances** on AWS, each running a different tech stack (Node.js, Java, Python, Go, Nginx, Redis, MongoDB, MySQL, RabbitMQ, etc.)
- **Custom DNS** with Amazon Route 53 for seamless service discovery 🌐
- **One-click scripts** for each microservice and database – just run and relax! 😎
- **Production-style logging** and error handling in every script
- **Reusable, modular, and idempotent** Bash scripts

---

## 🗂️ Folder Structure & File Guide

| File/Script         | Description                                                                                   |
|---------------------|----------------------------------------------------------------------------------------------|
| `cart.service`      | Systemd unit for Cart microservice. Sets up env vars for Redis & Catalogue, runs Node.js app.|
| `cart.sh`           | 🚦 Automates Cart setup: Node.js install, user creation, app download, dependencies, service.|
| `catalogue.service` | Systemd unit for Catalogue microservice. Connects to MongoDB, runs Node.js app.              |
| `catalogue.sh`      | 📦 Automates Catalogue: Node.js, user, app, dependencies, MongoDB client, initial data load. |
| `frontend.sh`       | 🎨 Sets up Nginx frontend: installs, cleans, downloads app, configures, restarts service.    |
| `mongo.repo`        | YUM repo config for MongoDB installation.                                                    |
| `mongodb.sh`        | 🍃 Automates MongoDB: repo setup, install, remote access, service enable/start.              |
| `mysql.sh`          | 🐬 Automates MySQL: install, enable/start, secure root password.                             |
| `nginx.conf`        | Nginx config: reverse proxy for all backend APIs, static content, health checks.             |
| `payment.service`   | Systemd unit for Payment microservice. Env vars for Cart, User, RabbitMQ, runs uWSGI.        |
| `payment.sh`        | 💳 Automates Payment: Python, user, app, dependencies, systemd service.                      |
| `rabbitmq.repo`     | YUM repo config for RabbitMQ/Erlang.                                                         |
| `rabbitmq.sh`       | 🐇 Automates RabbitMQ: repo, install, enable/start, user/permissions.                        |
| `redis.sh`          | 🟥 Automates Redis: install, remote access, enable/start.                                     |
| `roboshop.sh`       | ☁️ Automates AWS EC2 provisioning & Route 53 DNS updates for all services.                   |
| `shipping.service`  | Systemd unit for Shipping microservice. Env vars for Cart & MySQL, runs Java app.            |
| `shipping.sh`       | 🚚 Automates Shipping: Maven/Java, user, app, build, MySQL client, data load, service.       |
| `user.service`      | Systemd unit for User microservice. Env vars for MongoDB & Redis, runs Node.js app.          |
| `user.sh`           | 👤 Automates User: Node.js, user, app, dependencies, systemd service.                        |

---

## 🛠️ How to Use

1. **Clone this repo** to your server:  
   ```bash
   git clone https://github.com/yourusername/roboshop-automation.git
   cd roboshop-automation/roboshop
   ```

2. **Run the script for each service** (as root):  
   ```bash
   sudo bash cart.sh
   sudo bash catalogue.sh
   sudo bash frontend.sh
   # ...and so on for each .sh file!
   ```

3. **Check service status:**  
   ```bash
   systemctl status cart
   systemctl status catalogue
   # ...etc.
   ```

4. **Provision AWS EC2 & DNS (optional):**  
   ```bash
   sudo bash roboshop.sh mongodb redis mysql rabbitmq catalogue user cart shipping payment frontend
   ```

---

## 📝 My Automation Journey

### 🏗️ Manual to Automated Infrastructure

- **Started with manual setup:**  
  - Launched 11 EC2 instances on AWS for each microservice/database.
  - Installed and configured: Nginx, Java, Python, Go, Node.js, Redis, MongoDB, MySQL, RabbitMQ.
  - Created custom domain names and managed DNS with Route 53.

- **Automated everything with Bash:**  
  - Wrote modular scripts for each component.
  - Used systemd for reliable service management.
  - Implemented robust logging and error handling.
  - Automated AWS provisioning and DNS with AWS CLI.

### 💡 What I Learned

- **Bash scripting best practices**: functions, logging, error handling, idempotency.
- **Systemd service management** for microservices.
- **AWS EC2 & Route 53 automation** with CLI.
- **Troubleshooting** real-world deployment issues.
- **End-to-end DevOps mindset**: from infrastructure to application delivery.

---

## 🌍 DNS & Cloud

- Used **Amazon Route 53** for DNS management.
- All services accessible via friendly domain names (e.g., `cart.srivenkata.shop`).
- Automated DNS record creation/updates with scripts.

---

## 🚀 Why This Project Stands Out

- **Real-world, production-style automation**
- **Multi-language, multi-stack orchestration**
- **Cloud-native, scalable, and repeatable**
- **Perfect for DevOps, SRE, and Cloud Engineer roles!**

---


---

##🛠️ Debugging & Troubleshooting Tips

During my automation journey, I faced several real-world issues that taught me valuable lessons in troubleshooting and DevOps best practices. Here’s what I learned and how I debugged common problems:

### 😅 My Common Mistakes & Lessons Learned

| Mistake                                             | Issue                                                                 | Fix / Lesson Learned                                                                                 |
|-----------------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| ❌🔄 Forgot to Update IP Address in Route 53         | After launching/restarting EC2, public IP changed, but DNS not updated | Always update DNS record. Use `🔍 nslookup <domain-name>` to verify DNS propagation.                  |
| ❌🔁 Missed Updating IP in `nginx.conf` for Proxy    | Backend IPs changed, Nginx config not updated, causing 502/504 errors  | Always update `📝 proxy_pass` in `nginx.conf` and 🔄 reload Nginx after changes.                      |
| ❌🔃 Forgot to Restart Services After Config Changes | Made config changes but forgot to restart service, so changes didn’t apply | Always restart the relevant service after any config change:<br> `🚀 sudo systemctl restart <service>` |

---

### 🛠️🔍 My Debugging Toolkit

| Task                   | Command Example                                         | Purpose/Tip                                                        |
|------------------------|--------------------------------------------------------|--------------------------------------------------------------------|
| 🔎 Check Listening Ports  | `netstat -lntp`                                        | See if your service is running and listening on the expected port. |
| 🌐 Test Port Connectivity | `telnet <ip/domain> <port>`                            | Check if a service is reachable from another server or your machine.|
| 🧭 Check DNS Resolution   | `nslookup <domain-name>`                               | Verify your domain points to the correct IP address.               |
| 🔄 Restart Services       | `sudo systemctl restart <service-name>`<br>`sudo systemctl status <service-name>` | Ensure your changes are applied and the service is running.         |

---

### 🌐📦 Common Ports for Roboshop Services

| 🚀 Service    | 🔢 Default Port |
|--------------|----------------|
| 🖥️ Frontend   | 80             |
| 🛒 Cart       | 8080           |
| 🍃 MongoDB    | 27017          |
| 🐬 MySQL      | 3306           |
| 🧊 Redis      | 6379           |
| 🐇 RabbitMQ   | 5672           |

---

> 💡✨ Each mistake made me a better troubleshooter and more reliable DevOps engineer!


### ☁️ Steps to Create AWS EC2 Instances

1. **Login to AWS Console** and go to EC2 Dashboard.
2. **Launch Instance**: Choose an Amazon Linux 2 or Ubuntu AMI.
3. **Configure Instance Details**: Set network, IAM role, etc.
4. **Add Storage**: Adjust disk size if needed.
5. **Add Tags**: Name your instance (e.g., `roboshop-cart`).
6. **Configure Security Group**: Open required ports (see table above).
7. **Review and Launch**: Select or create a key pair for SSH access.
8. **Associate Elastic IP** (optional): For static public IP.
9. **Update Route 53 DNS**: Point your domain/subdomain to the instance’s public IP.

---

### 💡 Pro Tips

- Always check port status and DNS before deep-diving into application logs.
- After any config or DNS change, clear your browser cache or use `curl` to avoid cached responses.
- Document every change—automation is only as good as your documentation!

---

**Sharing my mistakes and how I fixed them shows my real-world troubleshooting skills and my commitment to continuous learning—qualities I bring to every DevOps role!** 🚀

 
---

> *“Automation is good, so long as you know exactly where to put the machine.”* – Eliyahu Goldratt
## 🛠️ Related Repos & Continuous Learning 📚✨

Ready to level up your shell scripting and automation game? Explore my key repositories that showcase a progressive journey from basics to cloud-grade automation:

- 🐚 [LEARN-SHELLSCRIPT-PRACTICE](https://github.com/MAHALAKSHMImahalakshmi/LEARN-SHELLSCRIPT-PRACTICE) – Start here! Fundamentals, practice scripts, and troubleshooting gems for shell scripting newbies and pros alike. 🔍💡
- ☁️ [Roboshop-Automation-Scripts-AWS](https://github.com/MAHALAKSHMImahalakshmi/Roboshop-Automation-Scripts-AWS) – Jump into real-world, cloud-ready automation scripts that power robust microservices on AWS! 🚀🔥
- 🤖 [Automated-Roboshop-Setup-AWS.git](https://github.com/MAHALAKSHMImahalakshmi/Automated-Roboshop-Setup-AWS.git) – Hands-on integrated infrastructure setup scripts for a seamless Roboshop deployment experience. 🌐⚙️

---

## 🤝 Credits & Connect 💬❤️

Inspired by **cloud-native**, production-grade DevOps workflows and automation excellence.  
Crafted with passion and dedication by [**Mahalakshmi**](https://github.com/MAHALAKSHMImahalakshmi) 👩‍💻✨

---

## 🌱 Final Note 🚀🌟

Shell scripting has been a *game changer* in my DevOps career — it taught me the true **power of automation, modularity, and smart troubleshooting**. 💪🛠️

Let’s continue to build, automate, and innovate—*one script at a time!*  
Join me on this journey, and together we’ll unlock greater efficiencies and creative solutions in automation. 🎯💡✨

Happy scripting! 🎉🐚🚦

