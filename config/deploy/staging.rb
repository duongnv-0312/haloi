if ENV["LOCAL_DEPLOY"]
  server "localhost", user: "deploy", roles: %w(app db)
else
  instances = fetch(:instances)

  instances.each do |role_name, hosts|
    hosts.each_with_index do |host, i|
      roles = [role_name]
      roles << "db" if i == 0
      server host, user: "deploy", roles: roles
    end
  end
end
