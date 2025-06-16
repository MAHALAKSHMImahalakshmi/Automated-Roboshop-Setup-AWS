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

## 🙌 Thank You!

If you like this project or want to collaborate, feel free to connect!  
**Happy Automating!** 🤝✨

---

> *“Automation is good, so long as you know exactly where to put the machine.”* – Eliyahu Goldratt
