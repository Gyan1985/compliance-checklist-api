
# Compliance Checklist

This README provides the steps necessary to get the application up and running.

## Requirements

- Ruby: 3.3.6
- Rails: 8.0.0
- PostgreSQL

## Setup Instructions

### 1. Install Ruby and Rails

Ensure you have Ruby 3.3.6 and Rails 8.0.0 installed.

You can install Ruby using `rbenv` or `rvm`, and Rails using the following command:

```bash
gem install rails -v 8.0.0
```

### 2. Install Required Gems

Run the following command to install all the required gems:

```bash
bundle install
```

### 3. Configure PostgreSQL

Ensure PostgreSQL is installed and running on your system.

- Configure your PostgreSQL username and password in the application's database configuration file.

  Copy the sample configuration file:

  ```bash
  cp config/database.yml.sample config/database.yml
  ```

  Edit `config/database.yml` to set your PostgreSQL username and password.

### 4. Set Up the Database

Run the following command to create the database:

```bash
rails db:create
```

### 5. Start the Rails Server

Once the database is set up, you can start the Rails server:

```bash
rails server
```

The application should now be up and running at [http://localhost:3000](http://localhost:3000).