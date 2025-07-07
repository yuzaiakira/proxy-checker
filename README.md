# proxy-checker

[![GitHub repo](https://img.shields.io/badge/github-yuzaiakira/proxy--checker-blue)](https://github.com/yuzaiakira/proxy-checker)

---

## Overview

**proxy-checker** is a powerful and flexible Bash script designed to easily check if your proxy server is running and automatically configure your environment variables accordingly. It supports multiple proxy types and offers various handy command-line options for managing proxy settings with ease.

This tool helps developers and sysadmins quickly verify proxy availability and seamlessly set or unset proxy environment variables in their shell session, improving workflow efficiency and automation capabilities.

---

## Features

* Detect if a proxy server is running on a specified host and port.
* Automatically export proxy environment variables (`all_proxy`, `http_proxy`, `https_proxy`).
* Support for proxy types: `socks5`, `socks5h`, `http`, `https`.
* Options to reset (unset) proxy variables, check status only, and debug mode.
* Save and persist preferred proxy settings for future sessions.
* Fully configurable via command-line options.
* Easy to integrate into your shell startup or automation scripts.

---

## Installation

To use **proxy-checker** as a global command anywhere on your system without prefixing with `sh` or `source`, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yuzaiakira/proxy-checker.git
   cd proxy-checker
   ```

2. **Make the script executable:**

   ```bash
   chmod +x proxy-checker.sh
   ```

3. **Move the script to a directory in your PATH, for example `/usr/local/bin`:**

   ```bash
   sudo mv proxy-checker.sh /usr/local/bin/proxy-checker
   ```

4. **Now you can run `proxy-checker` directly from any terminal:**

   ```bash
   proxy-checker --help
   ```

> **Note:** For environment variable exports to affect your current shell session, use `source proxy-checker` or integrate the script call into your shell profile (e.g., `.bashrc`, `.zshrc`) accordingly.

---

## Usage and Options

```bash
proxy-checker [OPTIONS]
```

| Option          | Description                                                                |
| --------------- | -------------------------------------------------------------------------- |
| `--host <host>` | Set proxy host (default: `127.0.0.1`)                                      |
| `--port <port>` | Set proxy port (default: `10808`)                                          |
| `--type <type>` | Set proxy type (`socks5`, `socks5h`, `http`, `https`) (default: `socks5h`) |
| `-s`, `--save`  | Save the current proxy configuration as default                            |
| `--reset`       | Unset all proxy environment variables                                      |
| `--status`      | Show proxy status only without changing environment variables              |
| `--debug`       | Show detailed debug information                                            |
| `-h`, `--help`  | Show help message                                                          |

---

### Examples

* **Check default proxy and set environment variables:**

  ```bash
  source proxy-checker
  ```

* **Check a custom proxy and save settings:**

  ```bash
  source proxy-checker --host 192.168.1.100 --port 9050 --type socks5 --save
  ```

* **Show proxy status only:**

  ```bash
  proxy-checker --status
  ```

* **Reset (unset) all proxy environment variables:**

  ```bash
  proxy-checker --reset
  ```

* **Enable debug output:**

  ```bash
  proxy-checker --debug
  ```

---

## Contribution

Contributions, feature requests, and bug reports are welcome! This project is open for improvement and extension. Feel free to fork the repository and submit pull requests with enhancements or fixes.

Check out the [Wiki](https://github.com/yuzaiakira/proxy-checker/wiki) for more detailed documentation, usage tips, and development guidelines.

---

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/yuzaiakira/proxy-checker/blob/main/LICENSE) file for details.

---

## About

Made with ❤️ and ☕ by [Akira](https://github.com/yuzaiakira)

