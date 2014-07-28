require 'puppet/property/login'
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'puppet_x/mssql/helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'puppet_x/mssql/server_helper'))

Puppet::Type::newtype(:mssql_install) do
  ensurable

  newparam(:name, :namevar => true) do
    munge do |value|
      value.upcase
    end
  end

  newparam(:action) do
    newvalues(:install, :remove)
    defaultto(:install)
  end


  newparam(:source) do

  end

  newparam(:pid) do
    desc 'Specify the SQL Server product key to configure which edition you would like to use.'

  end

  newproperty(:features, :array_matching => :all) do
    desc 'Specifies features to install, uninstall, or upgrade. The list of top-level features include
          SQL, AS, RS, IS, MDS, and Tools. The SQL feature will install the Database Engine, Replication,
          Full-Text, and Data Quality Services (DQS) server. The Tools feature will install Management
          Tools, Books online components, SQL Server Data Tools, and other shared components.'
    newvalues(:SQL, :SQLEngine, :Replication, :FullText, :DQ, :AS, :RS, :IS, :MDS)
    munge do |value|
      if PuppetX::Mssql::ServerHelper.is_super_feature(value)
        PuppetX::Mssql::ServerHelper.get_sub_features
      else
        value
      end
    end
  end





  def validate
    # if !(File.exists? self[:source])
    #   fail ArgumentError, "#{:source}: #{self[:source]} does not exist on the system"
    # end

  end



end
