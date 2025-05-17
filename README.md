# 🚀 Ansible VPS Initial Setup for Debian/Ubuntu

[![Ansible Version](https://img.shields.io/badge/Ansible-2.9%2B-blue.svg)](https://docs.ansible.com/)
[![Platform](https://img.shields.io/badge/Platform-Debian%20|%20Ubuntu-orange.svg)]()
[![License](https://img.shields.io/badge/License-MIT-green.svg)]()

A robust Ansible playbook for automating the initial setup and security hardening of Debian/Ubuntu VPS instances. Set up a new server with secure SSH, firewall, fail2ban, and essential packages in minutes instead of hours.

## 📋 Features

This playbook automates the following tasks:

- **📦 System Packages**
  - Install common utilities and tools
  - Ensure sudo is available

- **🔒 User Management & SSH Hardening**
  - Create a new sudo user
  - Configure SSH key-based authentication
  - Disable root SSH login
  - Disable password authentication

- **🛡️ Security**
  - Update and upgrade system packages
  - Install and configure UFW (Uncomplicated Firewall)
  - Allow only essential ports (SSH)
  - Install and configure Fail2Ban

- **⚙️ System Configuration**
  - Set timezone
  - Configure hostname

## 🔧 Requirements

- Ansible 2.9+ on the control machine
- Target server running Debian or Ubuntu
- Python 3.x on the target server
- Initial root access to the target server

## 🚀 Quick Start

### 1️⃣ Clone this repository

```bash
git clone https://github.com/hrafn-07/ansible-vps-setup.git
cd ansible-initial-vps-setup
```

### 2️⃣ Generate SSH key

```bash
cd ssh
./generate_ssh_key.sh
cd ..
```

The script will generate `ansible_user_key` and `ansible_user_key.pub` in the `ssh/` directory.

### 3️⃣ Configure your inventory

Edit `hosts.ini` with your server details:

```ini
[vms]
YOUR_SERVER_IP ansible_user=root ansible_ask_pass=true 
```

### 4️⃣ Configure variables

Edit `vars.yml` with your desired settings:

```yaml
new_user: your_username
user_pubkey: "{{ lookup('file', './ssh/ansible_user_key.pub') }}"
timezone: "Europe/Istanbul"
hostname: "my-vps"
```

### 5️⃣ Run the playbook

```bash
ansible-playbook -i hosts.ini playbook.yml --ask-pass
```

## 📁 Project Structure

```
ansible-initial-vps-setup/
├── ansible.cfg             # Ansible configuration
├── hosts.ini               # Inventory file
├── playbook.yml            # Main playbook
├── vars.yml                # Variables
├── ssh/
│   ├── ansible_user_key    # Private key (generated)
│   ├── ansible_user_key.pub # Public key (generated)
│   └── generate_ssh_key.sh # Key generation script
└── tasks/
    ├── packages.yml        # Package installation tasks
    ├── ssh.yml             # SSH configuration tasks
    ├── security.yml        # Security hardening tasks
    └── system.yml          # System configuration tasks
```

## ⚠️ Post-Installation

After running the playbook:
- Root SSH login will be disabled
- Password authentication will be disabled
- You must use your SSH key to connect:
  ```bash
  ssh -i ssh/ansible_user_key your_username@YOUR_SERVER_IP -p YOUR_SSH_PORT
  ```

## 🛠️ Customization

### Adding Additional Packages

Edit `tasks/packages.yml` to include additional packages:

```yaml
- name: Install common packages and sudo
  apt:
    name:
      - htop
      - curl
      # Add more packages here
    state: present
```

### Opening Additional Ports

Edit `tasks/security.yml` to allow additional ports through the firewall:

```yaml
- name: Allow additional ports in UFW
  ufw:
    rule: allow
    port: "80"  # Example: HTTP
    proto: tcp
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request