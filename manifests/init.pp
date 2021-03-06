# /etc/puppet/modules/cassandra/manifests/init.pp

class cassandra {

        require cassandra::params       
  	
   service { "cassandra-service":
        ensure => 'running',
        enable => true,
        hasstatus => true,
        start => "/etc/init.d/cassandra start",
        status => "/etc/init.d/cassandra status",
        stop => "/etc/init.d/cassandra stop",
        require => File["/etc/init.d/cassandra"],
   }

	file { "/etc/init.d/cassandra":
        ensure => present,
        content => template("cassandra/service/cassandra-service.erb"),
        require => File["/usr/local/cassandra"],
    }

	file { "/usr/local/cassandra":
		ensure => "directory",
		alias => "cassandra-home",
	}
	
        file {"$cassandra::params::cassandra_base":
		ensure => "directory",
		alias => "cassandra-base",
	}
        
        file {"$cassandra::params::cassandra_log_path":
		ensure => "directory",
		alias => "cassandra-log-path",
        require => File["cassandra-base"]
	}
	
        file {"$cassandra::params::data_path":
		ensure => "directory",
		alias => "cassandra-data-path",
	}
        
        file {"$cassandra::params::commitlog_directory":
		ensure => "directory",
		alias => "cassandra-commitlog-directory",
        require => File["cassandra-base"]
	}
        
        file {"$cassandra::params::saved_caches":
		ensure => "directory",
		alias => "cassandra-saved-caches",
        require => File["cassandra-base"]
	}
        
        file { "${cassandra::params::cassandra_base}/apache-cassandra-${cassandra::params::version}":
		ensure => "directory",
		mode => 0644,
		alias => "cassandra-app-dir",
                before => [ File["cassandra-yaml"], File["cassandra-log4j"], File["cassandra-env"] ]
	}
        
        file { "${cassandra::params::cassandra_base}/apache-cassandra-${cassandra::params::version}/conf/cassandra.yaml":
                alias => "cassandra-yaml",
                content => template("cassandra/conf/cassandra.yaml.erb"),
                mode => "644",
                require => File["cassandra-app-dir"]
        }
        
        file { "${cassandra::params::cassandra_base}/apache-cassandra-${cassandra::params::version}/conf/cassandra-env.sh":
                alias => "cassandra-env",
                content => template("cassandra/conf/cassandra-env.sh.erb"),
                mode => "644",
                require => File["cassandra-app-dir"]
        }
        
        file { "${cassandra::params::cassandra_base}/apache-cassandra-${cassandra::params::version}/conf/log4j-server.properties":
                alias => "cassandra-log4j",
                content => template("cassandra/conf/log4j-server.properties.erb"),
                mode => "644",
                require => File["cassandra-app-dir"]
        }
	file {"${cassandra::params::cassandra_base}/apache-cassandra-${cassandra::params::version}/lib/mx4j-tools.jar":
		ensure => present,
		source => "puppet:///modules/cassandra/mx4j-tools.jar",
		mode => "644",
	}

}
