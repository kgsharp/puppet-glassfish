Puppet::Type.newtype(:jdbcresource) do
  @doc = "Manage JDBC resources of Glassfish domains"
  ensurable

  newparam(:name) do
    desc "The JDBC resource name."
    isnamevar
  end

  newparam(:connectionpool) do
    desc "The JDBC connection pool name"
  end

  newparam(:portbase) do
    desc "The Glassfish domain port base. Default: 4800"
    defaultto "4800"
  end

  newparam(:domaindir) do
    desc "Specify domaindir to manage domains and resources in a different folder than under glassfish/domains/."
    defaultto nil
  end

  newparam(:asadminuser) do
    desc "The internal Glassfish user asadmin uses. Default: admin"
    defaultto "admin"
  end

  newparam(:passwordfile) do
    desc "The file containing the password for the user."

    validate do |value|
      unless File.exists? value
        raise ArgumentError, "%s does not exists" % value
      end
    end
  end

  newparam(:user) do
    desc "The user to run the command as."

    validate do |user|
      unless Puppet.features.root?
        self.fail "Only root can execute commands as other users"
      end
    end
  end
end
