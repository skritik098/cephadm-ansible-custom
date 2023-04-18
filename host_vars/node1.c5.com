
root_user: "True"

#registry_url: "registry.redhat.io"
#registry_username: "<USERNAME>"
#registry_pass: "xxxxx"

cluster_image: "" 
use_monitoring: "True"
cluster_network: ""


set_force: True


host_list:
        - name: node2
          address: 10.74.254.150 
          labels:
               - mon
               - mgr

initial_spec: |
          service_type: mon
          placement:
            hosts:
              - node1
              - node2
          ---
          service_type: mgr
          placement:
            hosts:
              - node1
              - node2
          ---
          service_type: osd
          service_id: all-available-devices
          service_name: osd.all-available-devices
          placement:
            host_pattern: '*'
          spec:
            data_devices:
              all: true
            filter_logic: AND
            objectstore: bluestore
