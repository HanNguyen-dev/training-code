# training-code
the official training codebase

Installing Docker, MSSQL Server with AdventureWorks for Windows 10 Home

1. Open Zsh.  Go to your virtual_machines directory.
2. Open vagrantfile in the directory.
    1. Change m.vm.box_version = "1.9.36" to m.vm.box_version = "1.9.38"
    2. Save and close the file.
3. In Zsh
    1. Run "vagrant box update"
    2. Run "vagrant up"    
4. (Optional) Check if vagrant is running and docker is installed in the linux virtual machine.
    1. Run "vagrant status"
    2. Run "vagrant ssh"
    3. Run "docker info"
    4. Run "exit" or Press CTRL + D.
    5. If vagrant is not running or docker is not installed, well you are on your own. :->
5. Run "brew install docker" (this is in WSL)
6. Adding the ssh key (from the virtual machines directory)
    1. Run "chmod 600 .vagrant/machines/master/virtualbox/private_key"
    2. Run "vagrant ssh-config"
    3. Record your IP address and port number
        1. This is abit different from Fred's instruction. Fred used VirtualBox to add a new port number in the Network Setting, this instruction is going to use commandlines instead for docker.
        2. Example: IP Address is 127.0.0.1 with port 2222.
        3. Run the next commandline (step 4 below) with your IP Address and port number.  The flag "-p" specify the port number.
    4. Run "ssh -p 2222 -i .vagrant/machines/master/virtualbox/private_key vagrant@127.0.0.1"
    5. Answer "yes" to the prompt.
    6. Run "exit" or Press CTRL + D.
    7. Run "eval $(ssh-agent)" 
    8. Run "ssh-add -k .vagrant/machines/master/virtualbox/private_key"
7. With your IP Address and port number (This step check if docker is running and accessible)
    1. Example: IP Address is 127.0.0.1 and port number 2222, which will be written as 127.0.0.1:2222 in the commandline below.
    2. Run "docker --host ssh://vagrant@127.0.0.1:2222 info"
    3. There should be an error-free printout.
8. Run "echo 'export DOCKER_HOST=ssh://vagrant@127.0.0.1:2222' >> ~/.zshenv", with your IP and Port.
9. Run "source ~/.zshenv"
10. Run "docker info" to verify docker is operating.

Installing MSSQL and Downloading AdventureWorks2017
1. Go to revature directory and create directory "1_sql"
2. Go to 1_sql directory
3. Run "docker container run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password12345' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest"
4. Run "wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak"
5. Run "wget https://raw.githubusercontent.com/1910-oct21-dotnet/training-code/master/1_sql/dockerfile", (from training-code github)
6. Run "wget https://raw.githubusercontent.com/1910-oct21-dotnet/training-code/master/1_sql/restore.sql", (from training-code github)
7. Run "docker image build -t sqlserver ."
8. Run "docker container ls"
    1. Get the first 3 letters of the Container ID Name.  Example is edfe88f00c58, so only "edf" is necessary.
    2. Run "docker container stop edf", "edf" is from the previous step.
10. Run "docker container run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password12345' -p 1433:1433 --rm -d sqlserver"

Setting up Azure Data Studio and AdventureWorks2017
1. Open VirtualBox.
2. Select master, and go to settings.
3. From Settings --> Network --> Advanced --> Port Forwarding
4. Add new rule
    * Name: sql
    * Protocol: TCP
    * Host IP: Your IP again, (127.0.0.1)
    * Host Port: 1433
    * Guest IP: (ignore)
    * Guest Port: 1433
5. Click OK, and close VirtualBox
6. Open Azure Data Studio
7. Login
    * Connection type: Microsoft SQL Server
    * Server: Your IP (127.0.0.1)
    * Authentication type: SQL Login
    * User name: sa
    * Password: Password12345
    * Database: <Default>
    * Server Group: <Default>
    * Name: Anything (this will save your login) 
8. Open your 1_sql directory in Azure Data Studio.
9. May have to reconnect a few times.
10. Open restore.sql in 1_sql
11. Run restore.sql
