# /etc/puppet/modules/cassandra/manifests/params.pp

class cassandra::params {

        include java::params
        
        $java_home = $::hostname ? {
		default			=> "${java::params::java_base}/jdk${java::params::java_version}",
	}
	$version = $::hostname ? {
		default			=> "1.0.8",
	}
        
	$cassandra_base = $::hostname ? {
		default			=> "/usr/local/cassandra",
	}
        
	$data_path = $::hostname ? {
		default			=> "/var/lib/cassandra/data",
	}
        
        $commitlog_directory = $::hostname ? {
                default                 => "/var/lib/cassandra/commitlog",
        }
        
        $saved_caches = $::hostname ? {
                default                 => "/var/lib/cassandra/saved_caches",
        }
        
        $cluser_name = $::hostname ? {
                default                 => "Cassandra Cluster",
        }
        
        $initial_token = $::hostname ? {
                default                 => "0",
                cassandra-01          => "0",
                cassandra-02          => "42535295865117307932921825928971026432",
                cassandra-03          => "85070591730234615865843651857942052864",
                cassandra-04          => "127605887595351923798765477786913079296",
        }
        
        $seeds = $::hostname ? {
                default                 => "cassandra-01, cassandra-02",
        }
        
        $cassandra_log_path = $::hostname ? {
                default                 => "/var/log/cassandra",
        }
        
        $jmx_port = $::hostname ? {
                default                 => "7199",
        }
        
        $max_heap = $::hostname ? {
                default                 => "4G",    
        }
        
        $heap_newsize = $::hostname ? {
                default                 => "800M"
        }
}


