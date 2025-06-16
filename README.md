
# 🎃 Horrorland dbt Workshop

[![Powered by DataGym.io](https://img.shields.io/badge/Powered%20by-DataGym.io-%23005FFF?style=for-the-badge&logo=data&logoColor=white)](https://www.datagym.io)

> 🚨 **IMPORTANT NOTICE**
> 👉 This repository is a **read-only template created exclusively for the DataGym.io Workshop**.
> ❌ **Do not open Pull Requests or merge any changes into this repository.**

Welcome to **Horrorland** – the most terrifying theme park experience on Earth.

As Halloween approaches, the leadership is panicking. Visitor satisfaction is down, and no one really knows why. The data is chaotic, and the analytics team has been tasked with finding answers.

Your job as an analytics engineer is to use **Snowflake** and **dbt** to bring order to this chaos and uncover critical insights.

---

## 📚 Table of Contents

- [👻 Context](#-context)
- [❄️ Getting Started with Snowflake](#️-getting-started-with-snowflake)
- [⚙️ Setting Up dbt Fusion](#️-setting-up-dbt-fusion)
- [🔐 Setting Environment Variables](#-setting-environment-variables)
- [🏗️ Creating Your dbt Project](#️-creating-your-dbt-project)
- [💡 What You’ll Learn](#-what-youll-learn)
- [💬 Support & Questions](#-support--questions)

---

## 👻 Context

You work at **Horrorland**, a spooky and thrilling theme park.

The Halloween season is coming, but something is wrong:
- Visitors are unhappy
- VIP guests may not be getting their money’s worth
- Ticket pricing might be completely off
- Fear levels seem to influence reviews — or do they?

Leadership needs answers to the following:

1. Which haunted houses have the happiest visitors?
2. Are VIP visitors actually more satisfied?
3. Which ticket type delivers the best value (perceived value vs price)?
4. Is there a relationship between fear level and visitor ratings?
5. Are certain visitor types more likely to recommend the park?

Time to find out — using dbt!

---

## ❄️ Getting Started with Snowflake

### 1. Create a Snowflake Trial Account

Go to [signup.snowflake.com](https://signup.snowflake.com/) and create a free trial account.

➡️ Select the **Enterprise** edition
➡️ Choose **AWS** as your cloud provider
➡️ Set up a **username and password**, and save your **account name**

---

### 2. Ingest Raw Data

In a real company, data engineers would handle ingestion pipelines. For this workshop, we'll simulate that by manually loading the raw data.

🧪 Steps:
1. Open your **Snowflake Web UI**
2. Create a new worksheet
3. Copy the contents of [`snowflake_insert.txt`](./snowflake_insert.txt)
4. Paste and run it inside your warehouse to create the raw tables

---

## ⚙️ Setting Up dbt Fusion

We'll use **dbt Fusion**, the new high-performance engine from dbt Labs.

### ✅ Option 1 (Recommended): Use the [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=dbt-labs.dbt)

Install the official **dbt Language Server** extension in VS Code and it will install dbt Fusion by default.

---

### 💻 Option 2: Install via CLI

#### macOS / Linux
```bash
curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update
exec $SHELL
```

#### Windows (PowerShell)

```powershell
irm https://public.cdn.getdbt.com/fs/install/install.ps1 | iex
Start-Process powershell
```

#### ✅ Verify Installation

```bash
dbtf --version
```

To update:

```bash
dbtf system update
```

To uninstall:

```bash
dbtf system uninstall
```

---

Ótimo ponto! Aqui está a seção **🔐 Setting Environment Variables** atualizada com instruções detalhadas de **onde encontrar cada variável** no Snowflake — especialmente o `SNOWFLAKE_ACCOUNT`, com passo a passo visualizado:

---

### 🔐 Setting Environment Variables

To connect dbt to Snowflake, you need to define the following environment variables:

| Variable               | Description                                                      |
| ---------------------- | ---------------------------------------------------------------- |
| `SNOWFLAKE_ACCOUNT`    | Your Snowflake **account identifier**                            |
| `SNOWFLAKE_USER`       | Your Snowflake **login username**                                |
| `SNOWFLAKE_PASSWORD`   | Your Snowflake **login password**                                |
| `SNOWFLAKE_DEV_SCHEMA` | A custom schema name for your dev models (e.g. `workshop_maria`) |

---

### 🔍 Where to find this information?

#### 🧭 SNOWFLAKE\_ACCOUNT (Account Identifier)

1. Go to your **Snowflake Web UI**
2. Click on your **user name** (bottom left corner)
3. Choose **"Account"**
4. Then select **"Account Details"**
5. Copy the **Account Identifier**
   👉 Example: `ABCDYID-FG74739`

This is what you'll use as your `SNOWFLAKE_ACCOUNT`.

#### 👤 SNOWFLAKE\_USER and SNOWFLAKE\_PASSWORD

These are the credentials you used when signing up on Snowflake.

#### 🏷 SNOWFLAKE\_DEV\_SCHEMA

This is a custom name you define, like `workshop_<yourname>`.
You will use this schema for creating your models without interfering with others.

---

### ✅ Preferred: Set Environment Variables Permanently

#### On macOS / Linux (bash/zsh)
1. Open your terminal and run:
    ```bash
    nano ~/.zshrc  # or ~/.bashrc depending on your shell
    ```

2. Add the following lines at the bottom:

   ```bash
   export SNOWFLAKE_ACCOUNT='your_account'
   export SNOWFLAKE_USER='your_user'
   export SNOWFLAKE_PASSWORD='your_password'
   export SNOWFLAKE_DEV_SCHEMA='your_schema'
   ```
3. Save and reload:

   ```bash
   source ~/.zshrc  # or source ~/.bashrc
   ```

#### On Windows (PowerShell)

1. Open PowerShell **as Administrator**
2. Run the following commands (replace values):

   ```powershell
   [System.Environment]::SetEnvironmentVariable('SNOWFLAKE_ACCOUNT', 'your_account', 'User')
   [System.Environment]::SetEnvironmentVariable('SNOWFLAKE_USER', 'your_user', 'User')
   [System.Environment]::SetEnvironmentVariable('SNOWFLAKE_PASSWORD', 'your_password', 'User')
   [System.Environment]::SetEnvironmentVariable('SNOWFLAKE_DEV_SCHEMA', 'your_schema', 'User')
   ```

You may need to **restart your terminal or VS Code** for the changes to take effect.

---

### 🗂️ Alternative: Use a `.env` File (project-based)

Create a file named `.env` in the root of your `horrorland` project:

```env
export SNOWFLAKE_ACCOUNT='your_account'
export SNOWFLAKE_USER='your_user'
export SNOWFLAKE_PASSWORD='your_password'
export SNOWFLAKE_DEV_SCHEMA='your_schema'
```


Load it  with:

```bash
source .env  # macOS/Linux
```

On Windows (PowerShell):

```powershell
Get-Content .env | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
  }
}
```

---

### ✅ Test Your Configuration

To ensure everything is working:

```bash
dbtf debug
```

---


## 🏗️ Creating Your dbt Project

These steps will be done together during the workshop, but here’s the structure:

1. Define your `sources`

   * Add tests and freshness checks
2. Create `staging` models (`stg_*`)

   * Clean raw data and apply standard naming
3. Build your `marts` (fact and dimension tables)
4. Add schema tests and unit tests
5. (Optional) Create `snapshots` or `seeds` if needed

---

## 💡 What You’ll Learn

✔️ Connect dbt Fusion to Snowflake
✔️ Build a clean star schema
✔️ Add tests and freshness validations
✔️ Create staging and marts models
✔️ Run and interpret unit tests
✔️ Use dbt documentation and lineage features
✔️ Answer real business questions with SQL

---

## 💬 Support & Questions

If you have any questions during the workshop, use the following channels:

* `❓-duvidas-🇧🇷`/ `❓-questions-🇺🇸` for questions related to the workshop
* `support-suporte-🌎` for general help

---

Happy modeling… and beware of ghosts in the data! 👻
