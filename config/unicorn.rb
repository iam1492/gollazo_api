root = "/home/deployer/apps/gollazo_api/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.gollazo_api.sock"
worker_processes 2
timeout 30