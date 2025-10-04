
# 🧠 LGS-ITEC – Network Utility Project

A simple yet powerful **network diagnostics tool** developed as part of a school project in the subject *Informationstechnik (ITEC)*.  
The main goal was to create a **custom Linux command-line tool** that can be installed system-wide and used to quickly test and log network connectivity.

---

## 🚀 Overview

This project provides a custom command called **`testping`** that checks network availability via ICMP pings and offers simple logging, configuration, and backup handling.

It demonstrates knowledge in:
- Linux shell scripting (Bash)
- System installation via shell
- File operations, logging, and backup handling
- Basic network diagnostics

---

## ⚙️ Installation

```bash
git clone https://github.com/PsydoV2/LGS-ITEC-BashScript
cd LGS-ITEC-BashScript
sudo bash install.sh
````

The installer automatically:

* Copies the script into your system path
* Creates necessary config and log files
* Makes the `testping` command globally available

---

## 🧹 Uninstallation

```bash
sudo bash uninstall.sh
```

During uninstallation, backups of the log, host, and config files are created automatically in the current directory.
That means no data is lost accidentally — you can easily restore previous settings.

---

## 💡 Usage

Run the tool directly from your terminal:

```bash
testping [OPTIONS]
```

To view documentation:

```bash
man testping
```

---

## 🧩 Features

* ✅ Quick network connectivity tests via `ping`
* 📝 Automatic logging of results
* ⚙️ Custom configuration support
* 🔒 Safe uninstallation with backups
* 🧠 Educational example for Linux system scripting

---

## 📁 Project Structure

```
LGS-ITEC-BashScript/
├── install.sh         # Installs the command globally
├── uninstall.sh       # Removes the tool and creates backups
├── src/               # Source files for the command
├── LICENSE
└── README.md
```

---

## 📚 Educational Context

This project was created as part of the **Informationstechnik (ITEC)** class at the *Ludwig-Geißler-Schule Hanau*.
It demonstrates practical skills in **system administration**, **Bash scripting**, and **network diagnostics** under Linux.

---

## 🔮 Possible Improvements

* Add colored CLI output and status icons
* Extend to check multiple hosts in parallel
* Include uptime and latency statistics
* Add JSON/CSV export for data analysis

---

## 🧑‍💻 Author

**Sebastian Falter** <br>
🔗 [github.com/PsydoV2](https://github.com/PsydoV2)

---

## ⚖️ License

This project is licensed under the **MIT License** – feel free to use, modify, and learn from it.

