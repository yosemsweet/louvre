#
# Cookbook Name:: jenkins_slave
# Recipe:: default
#

jenkins_slave({
  :master => {
    :host => "ec2-50-18-187-126.us-west-1.compute.amazonaws.com",
    :port => 80,
    :public_key => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvhLOEVeeTVB8qldFA7rPhwzfk7dP1f/pOQJdaz6zFITDUwMgA+LOFRsOTZTejNQLvQ79lxqtTgXAyVWm5qglofiw2nusoSsHDiLW6OQQxb59DbSe6D1tXOQkJCRQzWNNbopiCrtViZq2ahe5Y6/lq7KoVa22sTCzaiF7igw1stzpWSSeaIO3dVR1mGeRx2dqSXQDLFl4Kngggqth3mHOfZo5LXkKq9ykQzQTMQF1fsxtzXskAKZ9iaEdn0YqUu/H5cyqYVW5bCIrsLcV+KvSaIkU55vruFywvUi9RAi5X5c6owQcvh0bgKeT0CwGx+hjEzAU1eGaL6Q78xoH2p7VFQ== root@ip-10-161-7-175",
    :master_key_location => "/home/deploy/.ssh/id_rsa"
  },
  :gem => {
    :install => "jenkins"
  }
})
