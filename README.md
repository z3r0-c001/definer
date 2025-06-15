# Definer: A Simple Linux CLI Dictionary Tool

<!-- Uncomment if you have a banner image -->
<!-- ![Definer Banner](https://yourimageurl.com/banner.png) -->

## 📚 About

**Definer** is a lightweight, command-line dictionary tool for Linux. It allows you to quickly retrieve word definitions using a simple syntax:

```sh
definer: <word>
```

### **Why Use Definer?**
- 🔎 **Fast** - No need to open a browser or app  
- 💻 **Integrated CLI Workflow** - Use it directly from the terminal  
- ⚡ **Works Offline** - Uses the local dictionary (`dict` command)  
- 🌐 **Online Fallback** - Uses an API if `dict` isn’t installed  
- ⚙ **Verbose Mode (`-v`)** - Allows forcing `dict` for definitions  

This tool is perfect for developers, writers, students, and anyone who prefers working in the terminal.

---

## Installation

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/z3r0-c001/definer.git
cd definer
```

### **2️⃣ Run the Installer**
```sh
sudo chmod +x definer.sh
sudo ./definer.sh
```

### **3️⃣ Verify Installation**
After installation, run:
```sh
definer: hello
```
If installed correctly, you should see:
```
hello: A greeting used to express friendliness.
```

**What This Does:**
- ✅ Installs the `definer` script in `/usr/local/bin/`
- ✅ Detects your shell (`bash`, `zsh`, etc.)
- ✅ Adds the **`definer:`** function to your shell configuration
- ✅ Reloads your shell profile  

---

## Features

✅ **Instant Word Definitions** - Look up words quickly by running `definer: <word>` in your terminal.  
✅ **Works Offline** - Uses the local `dict` command for fast, offline definitions.  
✅ **Online Fallback** - If `dict` is missing, Definer fetches definitions from an online dictionary API.  
✅ **Lightweight & Fast** - No unnecessary dependencies; runs instantly.  
✅ **Verbose Mode (`-v`)** - Forces usage of `dict` instead of API.  
✅ **Easy Installation & Removal** - Simple install/uninstall process.  
✅ **Shell-Agnostic** - Works with **Bash, Zsh, and Fish**.  

---

## Usage

### **Basic Word Lookup (API Default)**
```sh
definer: <word>
```
🔹 Example:
```sh
definer: computer
```
📌 **Output:**
```
computer: An electronic device for storing and processing data, typically in binary form.
```

### **Forcing `dict` Lookup (`-v` Verbose Mode)**
```sh
definer: <word> -v
```
🔹 Example:
```sh
definer: computer -v
```
📌 **Output (from `dict`):**
```
computer: (noun) An electronic device that processes information.
```

### **Checking Help**
```sh
definer: --help
```

---

## How Definer Works

### **1️⃣ Local Dictionary Lookup (Verbose Mode `-v`)**
If the `dict` command is installed on your system, **Definer will use it when `-v` is specified**.

- ✅ Fast and offline  
- ✅ Uses system dictionaries for accuracy  
- ✅ No network dependency  

#### **Example**
```sh
definer: computer -v
```

If `dict` is unavailable, it will fall back to API mode.

---

### **2️⃣ Online API Lookup (Default Mode)**
If `-v` is **not** used, Definer will **fetch definitions from an online dictionary API**.

- 🌍 Requires an internet connection  
- 📱 Uses `https://api.dictionaryapi.dev`  
- ⚡ Still provides fast definitions  

---

## Supported Shells

| Shell | Supported |
|--------|-----------|
| Bash   | ✅ Yes |
| Zsh    | ✅ Yes |
| Fish   | ⚠️ Requires manual setup |

---

## Troubleshooting

### **1️⃣ "Command Not Found" Error**
**Issue:** If `definer:` is not recognized after installation.  
**Solution:** Restart your terminal or manually source the shell profile:
```sh
source ~/.bashrc   # If using Bash
source ~/.zshrc    # If using Zsh
```

---

### **2️⃣ "No Definition Found" Error**
**Issue:** If Definer cannot find a definition.  
**Solution:**  
- Ensure the word is spelled correctly.  
- Try using a synonym or a simpler form of the word.  
- If using offline mode, check if `dict` is installed:
  ```sh
  dict test
  ```
  If `dict` is missing, install it with:
  ```sh
  sudo apt install dict  # Debian/Ubuntu
  sudo yum install dict  # RHEL/CentOS
  sudo dnf install dict  # Fedora
  ```

---

### **3️⃣ Forcing Offline Mode (`-v`)**
If you want to **force offline mode** and always use `dict`:
```sh
definer: <word> -v
```

---

## ❌ Uninstallation

To completely remove **Definer**, run:

```sh
sudo rm /usr/local/bin/definer
sudo rm /usr/local/bin/definer:
sed -i '/definer:/d' ~/.bashrc ~/.zshrc ~/.profile
```
There is also an `uninstall.sh` file available to use:

```sh
sudo chmod +x uninstall.sh
sudo ./uninstall.sh
```

This will:
- Remove the `definer` script  
- Delete the `definer:` function from your shell config  

---

## Contributing

We welcome contributions! To contribute:

1. **Fork the repo** on GitHub  
2. **Clone your forked repo**:
   ```sh
   git clone https://github.com/z3r0-c001/definer.git
   cd definer
   ```
3. **Create a new branch**:
   ```sh
   git checkout -b feature-branch
   ```
4. **Make changes & commit**:
   ```sh
   git commit -m "Added new feature"
   ```
5. **Push changes**:
   ```sh
   git push origin feature-branch
   ```
6. **Submit a Pull Request (PR)**  

---

## License

This project is licensed under the **MIT License** with attribution.

### Attribution Requirement
If you use or modify this project, you must provide credit by including the following:

```
This project is based on "Definer: A Simple Linux CLI Dictionary Tool" by z3r0-c001, available at https://github.com/z3r0-c001/definer
```

See the [LICENSE](license) file for full details.

---

## 🔗 Links

- 📂 **GitHub Repo**: [github.com/z3r0-c001/definer](https://github.com/z3r0-c001/definer)  
- 💬 **Report Issues**: [Open an Issue](https://github.com/z3r0-c001/definer/issues)  

