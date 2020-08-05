COM1001 Introduction to Software Engineering
===========================================
Group 31 Team Software Project
---------------------------
<img src="./pizza31/public/images/logo/logo.png" width="150">

### Download Pizza31
  ```bash
  git clone https://github.com/COM1001/team-31.git
  ```
### Installing required gems
  Navigate to the directory where Pizza31 was downloaded.

  ```bash
  cd team-31
  ```

  Install the bundler gem
  ```bash
  gem install bundler
  ```

  Install the gem dependencies
  ```bash
  bundle install
  ```

### Using Rake commands
 To restore the databases to initial state (**run this first after cloning**)
  ```bash
  rake restoredb
  ```

 To run the application
 ```bash
 rake run
 ```

 To run the Cucumber test (**it will automatically run restoredb**)
 ```bash
 rake cucumber
 ```

 To run the MiniTest (minitest.rb)
 ```bash
 rake test
 ```

## File Directory Structure

- **[databases](./databases) (SQL text files)**

- **[pizza31](./pizza31) (Application controller)**

- **[testing](./testing) (Cucumber and MiniTest)**

- **Gemfile**
  > Contains the required gems to run the program, used by bundler

- **Rakefile**
  > Task management

- **Group31.pdf**
  > Group requirements document from Autumn semester

- **report-first-iteration.pdf**
  > First iteration report from Spring semester
